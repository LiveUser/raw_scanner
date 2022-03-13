import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:raw_scanner/raw_scanner.dart';

void main() => runApp(Runner());

class Runner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String? scanResults = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: ()async{
                scanResults = await RawScanner.scanCode(
                  typeOfCode: BarcodeFormat.qrcode, 
                  context: context,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.cyan,
                );
                print(scanResults);
                if(scanResults != null){
                  setState(() {
                    scanResults = scanResults;
                  });
                }
              }, 
              child: Text(
                "Scan",
              ),
            ),
            RawScanner.generateQrCode(
              data: scanResults!,
            ),
          ],
        ),
      ),
    );
  }
}