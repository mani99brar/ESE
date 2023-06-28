const express = require("express");
const path = require("path");
const app = express();


app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));


const server = app.listen(5001);
const portNumber = server.address().port;
console.log({ portNumber });

app.get("/",async (req, res) => {
//   const network = process.env.ETHEREUM_NETWORK;
// //   console.log(JSON.stringify(abi))
//   const web3 = new Web3(
//     new Web3.providers.HttpProvider(
//       `https://${network}.infura.io/v3/${process.env.INFURA_API_KEY}`
//     )
//   );
//   console.log(process.env.SIGNER_PRIVATE_KEY);
//   const signer = web3.eth.accounts.privateKeyToAccount(
//     process.env.SIGNER_PRIVATE_KEY
//   );
// //   console.log(signer);
//   web3.eth.accounts.wallet.add(signer);
// //   console.log(web3.eth.accounts);
// //   Creating a Contract instance
//   const contract = new web3.eth.Contract(
//     abi,
//     process.env.CONTRACT
//   );
  
//   const transactionParameters1 = {
//     to: process.env.CONTRACT, // Required except during contract publications.
//     from: "0xFa00D29d378EDC57AA1006946F0fc6230a5E3288", // must match user's active address.
//     data: contract.methods.buyToken().encodeABI(),
//   };

//   const transactionParameters3 = {
//     to: process.env.CONTRACT, // Required except during contract publications.
//     from: "0xFa00D29d378EDC57AA1006946F0fc6230a5E3288", // must match user's active address.
//     data: contract.methods.redeemTokens(2).encodeABI(),
//   };
  
    
  res.render("index2");
});
