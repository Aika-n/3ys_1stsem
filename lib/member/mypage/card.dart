import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../member.dart';

class CardRegisterPage extends StatefulWidget {
  CardRegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CardRegisterPageState createState() => _CardRegisterPageState();
}

class _CardRegisterPageState extends State<CardRegisterPage> {
  //キー
  final _formKey = GlobalKey<FormState>();

  //カード登録用変数（キーボード）
  final _cardNumber = TextEditingController();
  final _dateOfExpiry = TextEditingController();
  final _securityCode = TextEditingController();

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
        body: Form(
          key: _formKey, // 作成したフォームキーを指定
          child: SingleChildScrollView(
            padding:
            EdgeInsets.only(top: 50),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //カード名義
                  Padding(
                    padding: EdgeInsets.only(bottom: 70, right: 30, left: 30),
                    child: TextFormField(
                      controller: _cardNumber,
                      keyboardType: TextInputType.phone,
                      //数字以外打てない
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      obscureText: false,
                      autocorrect: false,
                      enableInteractiveSelection: false,
                      maxLength: 12,
                      decoration: InputDecoration(
                        labelText: 'カード名義',
                        icon: Icon(Icons.account_circle),
                      ),
                      //バリテーションチェック
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'テキストを入力してください。';
                        } else if (value.indexOf(' ') >= 0 ||
                            value.trim() == '') {
                          return '空文字は受け付けていません。';
                        } else if (value.indexOf('　') >= 0 ||
                            value.trim() == '') {
                          return '空文字は受け付けていません。';
                        }
                      },
                    ),
                  ),
                  //カード番号登録
                  Padding(
                    padding: EdgeInsets.only(bottom: 70, right: 30, left: 30),
                    child: TextFormField(
                      controller: _cardNumber,
                      keyboardType: TextInputType.phone,
                      //数字以外打てない
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      obscureText: false,
                      autocorrect: false,
                      enableInteractiveSelection: false,
                      maxLength: 12,
                      decoration: InputDecoration(
                        labelText: 'カード番号',
                        icon: Icon(Icons.title),
                      ),
                      //バリテーションチェック
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'テキストを入力してください。';
                        } else if (value.indexOf(' ') >= 0 ||
                            value.trim() == '') {
                          return '空文字は受け付けていません。';
                        } else if (value.indexOf('　') >= 0 ||
                            value.trim() == '') {
                          return '空文字は受け付けていません。';
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //有効期限
                      Container(
                        width: 250.0,
                        child: TextFormField(
                          controller: _dateOfExpiry,
                          keyboardType: TextInputType.phone,
                          //数字以外打てない
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          obscureText: false,
                          autocorrect: false,
                          enableInteractiveSelection: false,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: '有効期限',
                            icon: Icon(Icons.access_time_rounded),
                          ),
                          //バリテーションチェック
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'テキストを入力してください。';
                            } else if (value.indexOf(' ') >= 0 ||
                                value.trim() == '') {
                              return '空文字は受け付けていません。';
                            } else if (value.indexOf('　') >= 0 ||
                                value.trim() == '') {
                              return '空文字は受け付けていません。';
                            }
                          },
                        ),
                      ),
                      //セキュリティーコード
                      Container(
                        width: 250.0,
                        child: TextFormField(
                          controller: _securityCode,
                          keyboardType: TextInputType.phone,
                          //数字以外打てない
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          obscureText: false,
                          autocorrect: false,
                          enableInteractiveSelection: false,
                          maxLength: 3,
                          decoration: InputDecoration(
                            labelText: 'セキュリティーコード',
                            icon: Icon(Icons.security),
                          ),
                          //バリテーションチェック
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'テキストを入力してください。';
                            } else if (value.indexOf(' ') >= 0 ||
                                value.trim() == '') {
                              return '空文字は受け付けていません。';
                            } else if (value.indexOf('　') >= 0 ||
                                value.trim() == '') {
                              return '空文字は受け付けていません。';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      //追加ボタン
                      Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: MaterialButton(
                          height: 70.0,
                          minWidth: 180.0,
                          child: Text(
                            "追加する",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          color: Colors.blue,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            //登録処理
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemberPage(select: 2),
                                ));
                          },
                        ),
                      ),
                      //ホームに戻るボタン
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: MaterialButton(
                          height: 70.0,
                          minWidth: 180.0,
                          child: Text("マイページに戻る"),
                          color: Colors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemberPage(select: 2),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
