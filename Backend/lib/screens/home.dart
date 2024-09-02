import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF303030),
      appBar: AppBar(
        backgroundColor: Color(0xff212121),
        title: Text("Solana Wallet",style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffFFFFFF), fontSize: 30)),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(onPressed: (){
              Navigator.pushNamed(context, '/balance');
            },
              heroTag: null,
              backgroundColor: Color(0xffBB86FC),
              label: Text("Check SOL Balance"),
              icon: Icon(Icons.account_balance)
            ),
            SizedBox(height: 100),
            FloatingActionButton.extended(onPressed: (){
              Navigator.pushNamed(context, '/generateWallet');
            },
                heroTag: null,
                backgroundColor: Color(0xffBB86FC),
                label: Text("Generate SOL Wallet"),
                icon: Icon(Icons.wallet)
            )
          ],
        ),
      ),
    );
  }
}
