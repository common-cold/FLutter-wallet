# Flutter Wallet
A Web3 Wallet based on Flutter and Javascript.

## Description
This project is based on Solana ecosystem. 
It can show the balance pf the wallet and can generate a  wallet on solana
The backend is created in express.js
The frontend is created in Flutter.


## Installing
1. Download the code from this repository.
2. Run app.js present in /Backend/app.js
3. Ensure your pc and android device are on same network
4. Open main.dart present at /Frontend/lib/main.dart
5. At Function getMnemonic() present at screens/generatekeypair change the url to "http://<your-pc-ip-address>:3000/getPhrase"
6. At Function getBalance() present at screens/balance change the url to "http://<your-pc-ip-address>:3000/getBalance"
7. Connect your android mobile to flutter app and run the main.dart file.

> [!NOTE]
>  Ensure your pc and android device are on same network
>  At Function getMnemonic() present at Frontend/lib/main.dart change the url to "http://<your-pc-ip-address>:3000/getPhrase"
> At Function getBalance() present at screens/balance change the url to "http://<your-pc-ip-address>:3000/getBalance"
