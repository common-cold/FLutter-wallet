import express from "express"
import {getPhrase,getKeyPair,getBalance,getCoinPrice} from "./scripts/script.js"


const app = express();

// setInterval(getCoinPrice,10000);
export var coinPrice = await getCoinPrice();

app.use(express.json())

app.get("/getPhrase", (req,res) => {
    const {mnemonicList,publicKey,privateKey} = getPhrase();
    res.json({
         mnemonic: mnemonicList,
         publicKey: publicKey,
         privateKey: privateKey
     }); 
});

app.post("/getBalance", async(req,res) => {
    console.log("yooo came here");
    console.log(req.body);
    const publicAddress = req.body.address;
    const {sols,usdPrice} = await getBalance(publicAddress);
    
    if(sols == -1){
        res.status(404);
    }
    else{
        res.status(200);
    }


    res.json({
        sols: `${sols}`,
        balance: `$${usdPrice}`
    })
})

export default app;