// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

//0x6255581A224c8f1195d60e08717AcaD7f1269567
import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);
  function description() external view returns (string memory);
  function version() external view returns (uint256);
  function getRoundData(uint80 _roundId) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
  function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}



contract NewCoin is ERC20, ERC20Burnable, Ownable {
    AggregatorV3Interface internal _priceFeed;

    event TokenBought(address, uint256);
    event TokensRedeemed(address,uint256);
    uint256 private constant _MAX_SUPPLY = 1e18; // Maximum supply of nUSD
    uint256 private _currentSupply; // Current supply of nUSD

    constructor() ERC20("nUSD", "nUSD") {
        _priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        _currentSupply = 0;
    }

    function getPrice() public view returns (int256) {
        (, int256 price,,,) = _priceFeed.latestRoundData();
        return price;
    }

    function mint(address to, uint256 amount) internal {
        require(_currentSupply + amount <= _MAX_SUPPLY, "Exceeds maximum supply");
        _mint(to, amount);
        _currentSupply += amount;
    }

    function buyToken() payable external {
        require(msg.value > 0, "Invalid amount");
        uint256 ethToUsd = uint256(getPrice()/1e8);
        uint256 amount = (msg.value * ethToUsd) / (2*1e18);
        require(_currentSupply + amount <= _MAX_SUPPLY, "Exceeds maximum supply");
        emit TokenBought(msg.sender, amount);
        mint(msg.sender, amount);
    }

     function redeemTokens(uint256 amount) external {
        require(amount > 0, "Invalid amount");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        
        uint256 ethToUsd = uint256(getPrice()/1e8);
        uint256 ethAmount = (amount*1e18)/(2*ethToUsd);
        require(address(this).balance >= ethAmount, "Insufficient contract balance");
        payable(msg.sender).transfer(ethAmount);
        emit TokensRedeemed(msg.sender, amount);
        _currentSupply-=amount;
        _burn(msg.sender, amount);
    }
    

    function getCurrentSupply() public view returns (uint256) {
        return _currentSupply;
    }

    function getMaxSupply() public pure returns (uint256) {
        return _MAX_SUPPLY;
    }

    function getTokenBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}

