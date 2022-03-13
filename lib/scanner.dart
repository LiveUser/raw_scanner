import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class Scanner extends StatefulWidget {
  @required final BarcodeFormat typeOfCode;
  final Widget? title;
  final bool centerTitle;
  final Color foregroundColor;
  final Color backgroundColor;
  Scanner({
    required this.typeOfCode,
    required this.title,
    required this.centerTitle,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;

  @override
  void dispose() {
    if(controller != null){
      controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _onCreated = (QRViewController myController){
      controller = myController;
      //Update the UI to avoid null controller
      setState(() {
        
      });
      controller!.scannedDataStream.listen((result) {
        //Return value if it is the in the format we want
        if(widget.typeOfCode == result.format){
          controller!.stopCamera();
          Navigator.pop(context, result.code);
        }
      });
    };

    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        centerTitle: widget.centerTitle,
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation){
            if(orientation == Orientation.portrait){
              return Stack(
                children: [
                  ScannerView(qrKey: qrKey, onCreated: _onCreated),
                  //Controls
                  ScannerControlls(
                    controller: controller,
                    orientation: orientation,
                    foregroundColor: widget.foregroundColor,
                    backgroundColor: widget.backgroundColor,
                  ),
                  Crosshair(),
                ],
              );
            }else{
              return Stack(
                children: [
                  ScannerView(qrKey: qrKey, onCreated: _onCreated),
                  //Controls
                  ScannerControlls(
                    controller: controller,
                    orientation: orientation,
                    foregroundColor: widget.foregroundColor,
                    backgroundColor: widget.backgroundColor,
                  ),
                  Crosshair(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class Crosshair extends StatelessWidget {
  const Crosshair({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.center_focus_weak_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ScannerView extends StatelessWidget {
  const ScannerView({
    Key? key,
    required this.qrKey,
    required Null Function(QRViewController myController) onCreated,
  }) : _onCreated = onCreated, super(key: key);

  final GlobalKey<State<StatefulWidget>> qrKey;
  final Null Function(QRViewController myController) _onCreated;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey, 
      onQRViewCreated: _onCreated,
    );
  }
}

class ScannerControlls extends StatelessWidget {
  final QRViewController? controller;
  final double cornersRadius = 34;
  final Orientation orientation;
  final Color foregroundColor;
  final Color backgroundColor;
  ScannerControlls({
    required this.controller,
    required this.orientation,
    required this.foregroundColor,
    required this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    if(orientation == Orientation.portrait){
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(cornersRadius),
              topRight: Radius.circular(cornersRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (){
                  controller!.toggleFlash();
                }, 
                child: Icon(
                  Icons.flash_on,
                  color: foregroundColor,
                ),
              ),
              TextButton(
                onPressed: (){
                  controller!.flipCamera();
                }, 
                child: Icon(
                  Icons.flip_camera_android,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(cornersRadius),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (){
                  controller!.toggleFlash();
                }, 
                child: Icon(
                  Icons.flash_on,
                  color: foregroundColor,
                ),
              ),
              TextButton(
                onPressed: (){
                  controller!.flipCamera();
                },
                child: Icon(
                  Icons.flip_camera_android,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}