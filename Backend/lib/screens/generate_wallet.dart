import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3_app/model/get_keypair_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class GenerateWallet extends StatefulWidget {
  const GenerateWallet({Key? key}) : super(key: key);

  @override
  State<GenerateWallet> createState() => _GenerateWalletState();
}

class _GenerateWalletState extends State<GenerateWallet> {

  GetKeyPairResponse keyPairResponse = GetKeyPairResponse();

  List<String> mnemonicList = [];
  String publicKey = "";
  String privateKey = "";

  SnackBar snackbar = SnackBar(
    content: Text("Key Copied!"),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: ' ',
      onPressed: () {},
    ),
  );

  void getMnenmonic() async{
    var url = Uri.parse("http://192.168.29.157:3000/getPhrase");
    var response = await http.get(url);
    print('Response body: ${response.body}');
    keyPairResponse = GetKeyPairResponse.fromJson(jsonDecode(response.body));
    mnemonicList = keyPairResponse.mnemonic!;
    publicKey = keyPairResponse.publicKey!;
    privateKey = keyPairResponse.privateKey!;
    setState(() {});
    print(mnemonicList);
    print(publicKey);
    print(privateKey);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF303030),
      appBar: AppBar(
        backgroundColor: Color(0xff212121),
        title: Text("Generate Solana Wallet",style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffFFFFFF), fontSize: 25)),),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                  offset: Offset(0,-70.0),
                  child: FloatingActionButton.extended(
                    label: Text("Generate Mnenmonic", style: TextStyle(fontSize: 20)),
                    onPressed: (){
                      getMnenmonic();
                    },
                    backgroundColor: Color(0xffBB86FC)
                    ),
                  ),
              if(mnemonicList != null && mnemonicList.isNotEmpty)
                Column(
                  children: [
                    for (int i = 0; i < 4; i++) // Loop for rows
                      Row(
                        children: [
                          for (int j = 0; j < 3; j++) // Loop for columns
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    // Calculate index and handle out-of-bounds
                                    (i * 3 + j) < mnemonicList.length
                                        ? mnemonicList[i * 3 + j]
                                        : '',
                                    style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(50,80, 20, 0),
                        child: Row(children: [
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                ),
                                color: Color(0xffFFFFFF)
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Public Key",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Container(
                                height: 25,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xff000000)
                                ),
                                 child: Padding(
                                   padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                   child: Center(
                                     child: Text(
                                            publicKey, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500)
                                     ),
                                   ),
                                 )
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(onPressed: () {
                                Clipboard.setData(ClipboardData(text:publicKey))
                                    .then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);});
                              },
                                  child: Icon(Icons.copy),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF303030),
                                    padding: EdgeInsets.zero, // Remove default padding
                                  )
                              ),
                            ),
                          ),
                        ],)
                    ),Padding(
                        padding: EdgeInsets.fromLTRB(50, 40, 20, 0),
                        child: Row(children: [
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Colors.black
                                ),
                                color: Colors.white
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Private Key",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Container(
                                height: 25,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff000000)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                  child: Center(
                                    child: Text(
                                        publicKey, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500)
                                    ),
                                  ),
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(onPressed: () {
                                Clipboard.setData(ClipboardData(text:privateKey))
                                    .then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);});
                              },
                                  child: Icon(Icons.copy),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF303030),
                                    padding: EdgeInsets.zero, // Remove default padding
                                  )
                              ),
                            ),
                          ),
                        ],)
                    )
                  ],
                )

              else
                Text("No mnemonics available", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}
