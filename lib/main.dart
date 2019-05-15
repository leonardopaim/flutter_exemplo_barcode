import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<QrCameraState> qrCameraKey = GlobalKey();
  String codigo = "";
  int contador = 0;
  bool lendoCodigo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML Camera 3"),
      ),
      body: _body(),
    );
  }

  Container _body() {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  // String barcodeScanRes =
                  //     await FlutterBarcodeScanner.scanBarcode(
                  //         "#FF0000", "Cancelar");
                  // print(barcodeScanRes);
                  // setState(() {
                  //   codigo = barcodeScanRes;
                  // });
                },
                child: Container(
                  height: 200,
                  //color: Colors.amber,
                  child: QrCamera(
                    key: qrCameraKey,
                    qrCodeCallback: (code) async {
                      print("CODIGO DE BARRA:   $code");                      
                      qrCameraKey.currentState.stop();
                      await Future.delayed(Duration(seconds: 1));
                      qrCameraKey.currentState.restart();
                      setState(() {
                        codigo = code;
                        contador++;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 3,
                color: Colors.red,
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Contador: $contador \n Código: $codigo",
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
