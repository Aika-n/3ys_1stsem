import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginform/member.dart';
import 'package:loginform/member/home/use2.dart';

class Use1 extends StatelessWidget {
  Use1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(title), // <- (※2)
            automaticallyImplyLeading: false,
          ),
          body: Center(
              // <- (※3)
              child: ChangeForm())),
    );
  }
}

class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  //クーポン格納しているリスト
  static List<String> couponItems = <String>[];

  //支払い方法を格納しているリスト
  static List<String> creditItems = <String>[];

  //value用
  String _couponSelectedVal;
  String _creditSelectedVal;

  //カード用の変数（仮）
  String visa = 'visa';
  String credit = 'credit';
  String masterCard = 'MasterCard';

  String i = "100円引き";
  String j = "ECC太郎";

  //サーバーから送られてきたデータをリストに入れる
  void _strat() {
    if (i.isNotEmpty) {
      setState(() {
        couponItems.add(i);
      });
    }
    if (j.isNotEmpty) {
      setState(() {
        creditItems.add(j);
      });
    }
  }

  //ページを離れる際にリストの中身を空にする
  void _end() {
    if (i.isNotEmpty) {
      setState(() {
        couponItems.remove(i);
      });
    }
    if (j.isNotEmpty) {
      setState(() {
        creditItems.remove(j);
      });
    }
  }

  @override
  void initState() {
    _strat();
    super.initState();
  }

  String _text1 = '';
  String _text2 = '';

  void _handleText1(String e) {
    setState(() {
      _text1 = e;
    });
  }

  void _handleText2(String e) {
    setState(() {
      _text2 = e;
    });
  }

  //ここページ移行時のチェック
  void memo() {
    setState(() {
      if (_text1 == '' || _text2 == '') {
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
              builder: (context) => Use2(title: 'QRコード読み込み'),
            ));
        print(_text1);
        print(_text2);
      }
    });
  }

  Widget build(BuildContext context) {
    //クーポン用ドロップダウンリスト
    List<DropdownMenuItem<String>> _couponDownMenuItems = couponItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    //支払い方法用ドロップダウンリスト
    List<DropdownMenuItem<String>> _creditDownMenuItems = creditItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: SizedBox.fromSize(
              size: Size(200, 100), // button width and height
              child: ClipRRect(
                //角を丸める
                borderRadius: BorderRadius.all(Radius.circular(20)),
                //角の調整
                child: Material(
                  color: Colors.cyan,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.credit_card,
                        size: 40,
                        color: Colors.white,
                      ),
                      // icon
                      Text("決済方法",
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      // text
                    ],
                  ),
                ),
              ),
            ),
          ),
          //上の項目
          DropdownButton(
            value: _creditSelectedVal,
            hint: const Text('選んでください'),
            onChanged: (String newValue) => {
              setState(() {
                _creditSelectedVal = newValue;
                _handleText1(_creditSelectedVal);
              }),
            },
            items: _creditDownMenuItems,
          ),
          Container(
            child: SizedBox.fromSize(
              size: Size(200, 100), // button width and height
              child: ClipRRect(
                //角を丸める
                borderRadius: BorderRadius.all(Radius.circular(20)),
                //角の調整
                child: Material(
                  color: Colors.cyan,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.confirmation_num_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      // icon
                      Text("クーポン",
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                      // text
                    ],
                  ),
                ),
              ),
            ),
          ),
          //下の項目
          DropdownButton(
            value: _couponSelectedVal,
            hint: const Text('選んでください'),
            onChanged: (String newValue) => {
              setState(() {
                _couponSelectedVal = newValue;
                _handleText2(_couponSelectedVal);
              }),
            },
            items: _couponDownMenuItems,
          ),
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
              //ここページ移行時のチェック
              memo();
            },
          ),
          MaterialButton(
            height: 70.0,
            minWidth: 180.0,
            child: Text("ホームに戻る"),
            color: Colors.white,
            shape: const StadiumBorder(
              side: BorderSide(color: Colors.black),
            ),
            onPressed: () {
              _end();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberPage(select: 0),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
