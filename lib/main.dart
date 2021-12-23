import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanResult = "...";
  bool _isYoutube = false;
  bool _isLineLink = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Result',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _scanResult,
                  ),
                  _isYoutube
                      ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () async {
                              await launch(_scanResult);
                            },
                            child: Text(
                              'Open in yt',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red[900],
                          ),
                        )
                      : Container(),
                  _isLineLink
                      ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () async {
                              await launch(_scanResult);
                            },
                            child: Text(
                              'Open in Line app',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.green[600],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: startScan,
        color: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: SizedBox(
          width: 80,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              Text(
                'Scan',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  startScan() async {
    var lineColor = '#cb7e8a';
    var cancelButtonText = 'เลิก';
    var isShowFlashIcon = true;
    var scanMode = ScanMode.DEFAULT;

    var scanResult = await FlutterBarcodeScanner.scanBarcode(
        lineColor, cancelButtonText, isShowFlashIcon, scanMode);

    _isYoutube = false;

    if (scanResult != 1) {
      if (scanResult.contains('youtube.com')) {
        _isYoutube = true;
      }

      if (scanResult.contains('line.me')) {
        _isLineLink = true;
      }

      setState(() {
        _scanResult = scanResult;
      });
    }

    // print('Scanned : ${scanResult}');
  }
}
