import 'package:flutter/material.dart';
import 'package:loginform/member/home/use3.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Use2 extends StatefulWidget {
  Use2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Use2State createState() => _Use2State();
}

class _Use2State extends State<Use2> {
  //QRコードから読み込んだ値の格納先
  String qrCode = '';

  Future scanQrCode() async {
    //QRコードの処理　future=非同期処理のための機能
    final qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#EB394B', //色
      'Cancel', //キャンセルボタンのテキスト
      true, //フラッシュアイコンの有無
      ScanMode.QR,
    );
    if (!mounted) return;

    setState(() {
      //読み込んだ値の格納
      this.qrCode = "ECC１号店";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            //縦並び　横はrow
            mainAxisAlignment: MainAxisAlignment.center,
            //中央配置
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                child: SizedBox.fromSize(
                  size: Size(450, 250), // button width and height
                  child: ClipRRect(
                    //角を丸める
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    //角の調整
                    child: Material(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.water_damage_sharp,
                            size: 60,
                            color: Colors.white,
                          ),
                          Text(
                              "\n"
                                  "ご利用する洗濯機のQRコードを"
                                  "\nスキャンしてください"
                                  "\n",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white)),
                          Text("ご利用する洗濯機：" + '$qrCode',
                              style:
                              TextStyle(fontSize: 20, color: Colors.white)),
                          // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              MaterialButton(
                height: 70.0,
                minWidth: 180.0,
                child: Text(
                  "読み取り開始",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                shape: const StadiumBorder(
                  side: BorderSide(color: Colors.black),
                ),
                onPressed: () => scanQrCode(),
              ),
              SizedBox(height: 100),
              MaterialButton(
                height: 70.0,
                minWidth: 180.0,
                child: Text(
                  "次へ",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                shape: const StadiumBorder(
                  side: BorderSide(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Use3(title: 'コース選択'),
                      ));
                },
              ),
              SizedBox(height: 50),
              MaterialButton(
                height: 70.0,
                minWidth: 180.0,
                child: Text("戻る"),
                color: Colors.white,
                shape: const StadiumBorder(
                  side: BorderSide(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
