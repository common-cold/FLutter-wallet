# Flutter Wallet
A Web3 Wallet based on Flutter and Javascript.

## Description
This project is based on Solana ecosystem. 
It can show the balance pf the wallet and can generate a  wallet on solana
The backend is created in express.js
The frontend is created in Flutter.

## Images
> Home Page
![hp](https://github.com/user-attachments/assets/99a4e8cc-b1b6-4a0a-b1be-3338304cf6a4)

> Checking balance of any wallet
![balance1](https://github.com/user-attachments/assets/c84ac5cf-a853-4e15-a99e-b1647e437dc6)
![balance2](https://github.com/user-attachments/assets/3b4982b9-003d-4c15-bcaa-7a2d6fba667d)


> Creating a wallet on SOLANA
![wallet1](https://github.com/user-attachments/assets/4f0f6ad9-a271-424a-b0d4-ac65d5e54a32)
> ![wallet2](https://github.com/user-attachments/assets/ad6b0cef-937a-42f8-babf-68fb72e581fd)


 



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
