import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web3_app/model/get_balance.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  GetBalanceResponse getBalanceResponse = GetBalanceResponse();
  String solAmount = "0";
  String usdPrice = "0";
  String publicKey = "";
  bool _showTextField = true;

  final TextEditingController textController = TextEditingController();


  void getBalance(String publicKey) async {
    var url = Uri.parse("http://192.168.29.157:3000/getBalance");
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
      },
      body: jsonEncode({
        'address': publicKey
      })
    );

    if(response.statusCode != 200){
      SnackBar snackbar = SnackBar(
        content: Text("Invalid Address!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),),
        duration: Duration(seconds: 3),
        backgroundColor: Color(0xffBB86FC),
        action: SnackBarAction(
          label: ' ',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    else{
      getBalanceResponse = GetBalanceResponse.fromJson(jsonDecode(response.body));

      solAmount = getBalanceResponse.sols!;
      usdPrice = getBalanceResponse.balance!;
      _showTextField = false;
      setState(() {});
      print(solAmount);
      print(usdPrice);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF303030),
      appBar: AppBar(
        backgroundColor: Color(0xff212121),
        title: Text("Check SOL Balance",style: GoogleFonts.roboto(
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
              _showTextField?
              Container(
                width: 300,
                height: 50,
                  child: TextField (
                  controller: textController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffBB86FC), width: 2.5),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    border: OutlineInputBorder(), // Default border
                    focusedBorder: OutlineInputBorder( // Border when the TextField is focused
                        borderSide: BorderSide(color: Color(0xffBB86FC), width: 2.5),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    errorBorder: OutlineInputBorder( // Border when there's an error
                        borderSide: BorderSide(color: Color(0xffBB86FC), width: 2.5),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    disabledBorder: OutlineInputBorder( // Border when the TextField is disabled
                        borderSide: BorderSide(color: Color(0xffBB86FC), width: 2.5),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    hintText: 'Enter a public address',
                    hintStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto')
                  ),
               )
              ):
              Column(
                children: [
                  Text(solAmount+" SOL",style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 50),fontWeight: FontWeight.w400, color: Colors.white),),
                  SizedBox(height: 10),
                  Text(usdPrice,style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 50),fontWeight: FontWeight.w400, color: Colors.white),)
                ],
              ),
              SizedBox(height: 30),
              _showTextField ?
              FloatingActionButton.extended(onPressed: (){
                setState(() {
                  publicKey = textController.text;
                });
                print(publicKey);
                getBalance(publicKey);
              },
                label: Text("Check Balance"),
                backgroundColor: Color(0xffBB86FC)
              ):
              FloatingActionButton.extended(onPressed: (){
                setState(() {
                    _showTextField = true;
                });
              },
                  label: Text("Check Another Balance"),
                  backgroundColor: Color(0xffBB86FC)
              )
        ],
          ),
        ),
      ),
    );
  }
}