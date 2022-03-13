import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'scanner.dart';

class RawScanner{
  ///Generates a QR code and returns a Widget that displays it
  static Widget generateQrCode({
    required String data,
    double? size,
    EdgeInsets padding = const EdgeInsets.all(10.0),
    Color backgroundColor = Colors.transparent,
    Color? foregroundColor,
    int version = QrVersions.auto,
    int errorCorrectionLevel = QrErrorCorrectLevel.L,
    Widget Function(BuildContext, Object?)? errorStateBuilder,
    bool constrainErrorBounds = true,
    bool gapless = true,
    ImageProvider<Object>? embeddedImage,
    QrEmbeddedImageStyle? embeddedImageStyle,
    String semanticsLabel = 'qr code',
    QrEyeStyle eyeStyle = const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
    QrDataModuleStyle dataModuleStyle = const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black),
    bool embeddedImageEmitsError = false,
  }){
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: QrImage(
          data: data,
          size: size,
          padding: padding,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          version: version,
          errorCorrectionLevel: errorCorrectionLevel,
          errorStateBuilder: errorStateBuilder,
          constrainErrorBounds: constrainErrorBounds,
          gapless: gapless,
          embeddedImage: embeddedImage,
          embeddedImageStyle: embeddedImageStyle,
          semanticsLabel: semanticsLabel,
          eyeStyle: eyeStyle,
          dataModuleStyle: dataModuleStyle,
          embeddedImageEmitsError: embeddedImageEmitsError,
        ),
      ),
    );
  }
  ///Scan some type of BarCode like QR code, etc.
  static Future<String?> scanCode({
    required BarcodeFormat typeOfCode,
    required BuildContext context,
    ///Goes on the appbar
    Widget? title,
    final bool centerTitle = false,
    final Color foregroundColor = Colors.black,
    final Color backgroundColor = Colors.white,
  })async{
    String? data = await Navigator.push(context, MaterialPageRoute(
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