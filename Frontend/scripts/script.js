import { generateMnemonic, mnemonicToSeedSync } from "bip39";
import { Keypair } from "@solana/web3.js";
import { LAMPORTS_PER_SOL } from "@solana/web3.js";
import nacl from "tweetnacl";
import { derivePath } from "ed25519-hd-key";
import bs58 from 'bs58';
import axios from 'axios';
import { coinPrice } from "../app.js";


function sayHello() {
    console.log("HELLLO BROOO!!!");
}



function padDecimal(num,places){
  num = num.toString();
  num = num.slice(0,(num.indexOf(".") + places + 1));
  return Number(num);
}
  


function getPhrase() {
  console.log("came here");
  const mnemonic = generateMnemonic();
  const mnemonicList = mnemonic.split(" ");
  const {publicKey,privateKey} = getKeyPair(mnemonic);
  return{mnemonicList,publicKey,privateKey};  
}



function getKeyPair(mnemonic){
  const seed = mnemonicToSeedSync(mnemonic);
  const path = `m/44'/501'/1'/0'`;
  const derivedSeed = derivePath(path, seed.toString("hex")).key;
  const secret = nacl.sign.keyPair.fromSeed(derivedSeed).secretKey;
  const publicKey = Keypair.fromSecretKey(secret).publicKey.toBase58();
  const privateKey = bs58.encode(secret);
  return {publicKey,privateKey};
}



async function getBalance(publicAddress){
  const response = await axios.post("https://solana-mainnet.g.alchemy.com/v2/IA5XqK-rU0LYpFekBWARC-2_lWQNqmFG",{
    "jsonrpc": "2.0",
        "id": 1,
        "method": "getBalance",
        "params": [publicAddress]
  });
  const error = response.data.error;
  var sols = -1;
  var usdPrice = -1;
  if(error == undefined){
    const value = response.data.result.value;
    sols = value/LAMPORTS_PER_SOL;
    usdPrice = sols*coinPrice;
    sols = padDecimal(sols,4);
    usdPrice = padDecimal(usdPrice,2);
    return {sols,usdPrice};
  }
  else{
    return {sols,usdPrice};
  }

  
}



async function getCoinPrice(){
  const response = await axios.get("https://api.coingecko.com/api/v3/simple/price?ids=solana&vs_currencies=usd")
  const coinPriceResponse = response.data.solana.usd;
  console.log("updated the price");
  return coinPriceResponse;
}


export { getPhrase, sayHello, getKeyPair, getBalance, getCoinPrice};
