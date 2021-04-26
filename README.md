# raw_scanner

A simplified barcode scanner.

Hecho en Puerto Rico 🇵🇷 por Radamés J. Valentín Reyes

## What is this?

A package to scan barcodes(QR codes and others) in a simplified manner. It's a wrapper around tools rather than a personal project coded from scratch.

## Why did I make it?

Simplified flutter packages for scanning QR codes that I could find didn't work, the others were too time consuming to get them  to work, so I took the best among them and tried to simplify it.

## Importing the package

~~~dart
import 'package:raw_scanner/raw_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';//Importing the original library is important for using the BarcodeFormat enum which is a required parameter
~~~

## Use

### Note: "RawScanner" is the object that contains all of the methods.



The example below returns a Widget containing a QR code

~~~dart
RawScanner.generateQrCode("A string for the QR here")
~~~



The example below scans for the specified "typeOfCode" and returns it as a String. Take into account that the returned value may be null. 

~~~dart
String scanResults = await RawScanner.scanCode(
	typeOfCode: BarcodeFormat.qrcode, 
	context: context,
	foregroundColor: Colors.red,
);
~~~



## Full example

~~~dart
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
  String scanResults = "";

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
                  foregroundColor: Colors.red,
                );
                print(scanResults);
                setState(() {
                  scanResults = scanResults;
                });
              }, 
              child: Text(
                "Scan",
              ),
            ),
            RawScanner.generateQrCode(scanResults)
          ],
        ),
      ),
    );
  }
}
~~~



## Dependencies

* [qr_code_scanner: ^0.4.0](https://pub.dev/packages/qr_code_scanner)
* [qr_flutter: ^4.0.0](https://pub.dev/packages/qr_flutter)