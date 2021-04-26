import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'scanner.dart';

class RawScanner{
  ///Generates a QR code and returns a Widget that displays it
  static Widget generateQrCode(String data){
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: QrImage(data: data),
      ),
    );
  }
  ///Scan some type of BarCode like QR code, etc.
  static Future<String> scanCode({
    @required BarcodeFormat typeOfCode,
    @required BuildContext context,
    ///Goes on the appbar
    Widget title,
    final bool centerTitle = false,
    final Color foregroundColor = Colors.black,
    final Color backgroundColor = Colors.white,
  })async{
    String data = await Navigator.push(context, MaterialPageRoute(
        builder: (context)=> Scanner(
          typeOfCode: typeOfCode,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          title: title,
          centerTitle: centerTitle,
        ),
      ),
    );
    //Return the QR code result, might be null
    return data;
  }
}