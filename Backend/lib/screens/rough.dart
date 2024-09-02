import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3_app/model/get_keypair_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Welcome to Wallet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                  offset: Offset(0,-70.0),
                  child: ElevatedButton(
                    child: Text("Generate Mnenmonic", style: TextStyle(fontSize: 20,color: Colors.black)),
                    onPressed: (){
                      getMnenmonic();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue
                    ),
                  )),
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
                                    style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
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
                                    color: Colors.black
                                ),
                                color: Colors.blueGrey
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Public Key",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Container(
                                height: 25,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    color: Colors.grey
                                ),
                                child: Text(publicKey, overflow: TextOverflow.ellipsis)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 20,
                              height: 20,
                              child: ElevatedButton(onPressed: () {
                                Clipboard.setData(ClipboardData(text:publicKey))
                                    .then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);});
                              },
                                  child: Icon(Icons.copy),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: EdgeInsets.zero, // Remove default padding
                                    minimumSize: Size(20, 20), // Set the button size
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
                                color: Colors.blueGrey
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
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    color: Colors.grey
                                ),
                                child: Text(privateKey, overflow: TextOverflow.ellipsis)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 20,
                              height: 20,
                              child: ElevatedButton(onPressed: () {
                                Clipboard.setData(ClipboardData(text:privateKey))
                                    .then((value){
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);});
                              },
                                  child: Icon(Icons.copy),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: EdgeInsets.zero, // Remove default padding
                                    minimumSize: Size(20, 20), // Set the button size
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
