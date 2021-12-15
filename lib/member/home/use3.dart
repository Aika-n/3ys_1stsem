import 'package:flutter/material.dart';
import 'package:loginform/member/home/use4.dart';

class Use3 extends StatefulWidget {
  Use3({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Use3State createState() => _Use3State();
}

class _Use3State extends State<Use3> {
  // <- (※1)

  int status = 1;

  String _text = '';

  //情報はDBから取ってくる予定なので仮のデータ
  String wash22 = "900円";
  String wash12 = "800円";
  String wash7 = "600円";

  String dry22 = "400円";
  String dry12 = "300円";
  String dry7 = "300円";

  String washdry22 = "1700円";
  String washdry10 = "900円";
  String washdry7 = "1100円";

  String washmachine22 = "22kg洗濯機";
  String washmachine12 = "12kg洗濯機";
  String washmachine7 = "7kg洗濯機";

  String drymachine22 = "22kg乾燥機";
  String drymachine12 = "12kg乾燥機";
  String drymachine7 = "7kg乾燥機";

  String hybrid22 = "22kg洗濯乾燥機";
  String hybrid10 = "10kg洗濯乾燥機";
  String hybrid7 = "7kg洗濯乾燥機";

  String _kikai = '';
  String kikai = "0";

  //コースを格納しているリスト
  static List<String> courseItems = <String>[
    "通常コース/30分200円",
    "除菌電解水コース/40分500円",
  ];

  //value用
  String _courseSelectedVal;

  //ここページ移行時のチェック
  void memo() {
    setState(() {
      if (_text == '') {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("エラー"),
              content: Text("支払方法が選択されていません"),
              actions: <Widget>[
                // ボタン領域
                // FlatButton(
                //   child: Text("Cancel"),
                //   onPressed: () => Navigator.pop(context),
                // ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Use4(title: 'コース確認'),
            ));
        print(_text);
      }
    });
  }

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //コース用ドロップダウンリスト
    List<DropdownMenuItem<String>> _couponDownMenuItems = courseItems
        .map(
          (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    )
        .toList();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title), // <- (※2)
          automaticallyImplyLeading: false,
        ),
        body: Center(
            // <- (※3)
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: SizedBox.fromSize(
                size: Size(450, 250), // button width and height
                child: ClipRRect(
                  //角を丸める
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  //角の調整
                  child: Material(
                    color: Colors.deepPurpleAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.timelapse,
                          size: 60,
                          color: Colors.white,
                        ),
                        Text(
                            "\n"
                            "ご利用するコースを選択してください"
                            "\n",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        Text("ご利用の洗濯機：ECC１号店",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: DropdownButton(
                value: _courseSelectedVal,
                hint: const Text('選んでください'),
                onChanged: (String newValue) => {
                  setState(() {
                    _courseSelectedVal = newValue;
                    _handleText(_courseSelectedVal);
                  }),
                },
                items: _couponDownMenuItems,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: MaterialButton(
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
                  //ここページ移行時のチェック
                  memo();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: MaterialButton(
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
            )
          ],
        )),
      ),
    );
  }
}
