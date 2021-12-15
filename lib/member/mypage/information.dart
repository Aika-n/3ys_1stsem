import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../member.dart';

//会員情報
class InformationPage extends StatefulWidget {
  InformationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  //キー
  final _formKey = GlobalKey<FormState>();

  //キーボード
  final _password = TextEditingController();
  final _subPassWord = TextEditingController();
  final _newPassWord = TextEditingController();

  //データベースに登録してる情報を格納する変数（今は仮に文字入れてる）
  String userName = "ふくもと";
  String gender = "男";
  String age = "50代";
  String mailAddress = 'パスワードを入力すると公開されます';
  String phoneNumber = 'パスワードを入力すると公開されます';
  String password = 'aB111111';

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
        body: SingleChildScrollView(
          child: Column(
            //リスト
            children: <Widget>[
              //名前
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(userName),
                  subtitle: Text('ユーザー名'),
                ),
              ),
              //性別
              Card(
                child: ListTile(
                  leading: Icon(Icons.accessibility),
                  title: Text(gender),
                  subtitle: Text('性別'),
                ),
              ),
              //年代
              Card(
                child: ListTile(
                  leading: Icon(Icons.escalator_warning),
                  title: Text(age),
                  subtitle: Text('年代'),
                ),
              ),
              //メールアドレス
              Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    mailAddress,
                    style: TextStyle(color: Colors.red),
                  ),
                  subtitle: Text('メールアドレス'),
                  trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: Text("パスワード"),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _password,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        autocorrect: false,
                                        enableInteractiveSelection: false,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          labelText: '現在のパスワード',
                                          hintText: '現在のパスワードを入力してください',
                                        ),
                                        validator: (value) {
                                          String pattern1 =
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                                          String pattern2 =
                                              r'^(?=.*[!-/:-@\\[-`{-~]).{1,}$';
                                          RegExp regExp1 = new RegExp(pattern1);
                                          RegExp regExp2 = new RegExp(pattern2);

                                          //確認用の変数
                                          String answer;
                                          String check;
                                          setState(() {
                                            answer = _password.text;
                                            check = password;
                                          });

                                          if (value.isEmpty) {
                                            return 'パスワードを入力してください。';
                                          } else if (value.indexOf(' ') >= 0 ||
                                              value.trim() == '') {
                                            return '空文字は受け付けていません。';
                                          } else if (value.indexOf('　') >= 0 ||
                                              value.trim() == '') {
                                            return '空文字は受け付けていません。';
                                          } else if (!regExp1.hasMatch(value)) {
                                            return '大文字小文字数字を含めて８文字以上入力ください';
                                          } else if (regExp2.hasMatch(value)) {
                                            return '使用できない文字が含まれています';
                                          } else if (answer != check) {
                                            return 'パスワードが違います';
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    color: Colors.white,
                                    textColor: Colors.blue,
                                    child: Text('キャンセル'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                  FlatButton(
                                    color: Colors.white,
                                    textColor: Colors.blue,
                                    child: Text('OK'),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        //メールアドレスの表記を変更する処理
                                        setState(() {
                                          //ここにデータベースからメアド持ってくる処理書くかも
                                          mailAddress = 'hukumoto123@ecc.ac.jp';
                                          _password.text = "";
                                        });
                                        Navigator.of(context).pop(true);
                                      }
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ),
              //電話番号
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    phoneNumber,
                    style: TextStyle(color: Colors.red),
                  ),
                  subtitle: Text('電話番号'),
                  trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: Text("パスワード"),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _password,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        autocorrect: false,
                                        enableInteractiveSelection: false,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          labelText: '現在のパスワード',
                                          hintText: '現在のパスワードを入力してください',
                                        ),
                                        validator: (value) {
                                          String pattern1 =
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                                          String pattern2 =
                                              r'^(?=.*[!-/:-@\\[-`{-~]).{1,}$';
                                          RegExp regExp1 = new RegExp(pattern1);
                                          RegExp regExp2 = new RegExp(pattern2);

                                          //確認用の変数
                                          String answer;
                                          String check;
                                          setState(() {
                                            answer = _password.text;
                                            check = password;
                                          });

                                          if (value.isEmpty) {
                                            return 'パスワードを入力してください。';
                                          } else if (value.indexOf(' ') >= 0 ||
                                              value.trim() == '') {
                                            return '空文字は受け付けていません。';
                                          } else if (value.indexOf('　') >= 0 ||
                                              value.trim() == '') {
                                            return '空文字は受け付けていません。';
                                          } else if (!regExp1.hasMatch(value)) {
                                            return '大文字小文字数字を含めて８文字以上入力ください';
                                          } else if (regExp2.hasMatch(value)) {
                                            return '使用できない文字が含まれています';
                                          } else if (answer != check) {
                                            return 'パスワードが違います';
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    color: Colors.white,
                                    textColor: Colors.blue,
                                    child: Text('キャンセル'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                  FlatButton(
                                    color: Colors.white,
                                    textColor: Colors.blue,
                                    child: Text('OK'),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        //電話番号の表記を変更する処理
                                        setState(() {
                                          //ここにデータベースから電話番号を持ってくる処理書くかも
                                          phoneNumber = 'hukumoto1234';
                                        });
                                        Navigator.of(context).pop(true);
                                      }
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ),
              //パスワード変更
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: MaterialButton(
                  height: 70.0,
                  minWidth: 180.0,
                  child: Text(
                    "パスワード変更",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    showDialog<bool>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: Text("パスワード変更"),
                            content: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextFormField(
                                    controller: _password,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    autocorrect: false,
                                    enableInteractiveSelection: false,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      labelText: '現在のパスワード',
                                      hintText: '現在のパスワードを入力してください',
                                    ),
                                    validator: (value) {
                                      String pattern1 =
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                                      String pattern2 =
                                          r'^(?=.*[!-/:-@\\[-`{-~]).{1,}$';
                                      RegExp regExp1 = new RegExp(pattern1);
                                      RegExp regExp2 = new RegExp(pattern2);

                                      //確認用の変数
                                      String answer;
                                      String check;
                                      setState(() {
                                        answer = _password.text;
                                        check = password;
                                      });

                                      if (value.isEmpty) {
                                        return 'パスワードを入力してください。';
                                      } else if (value.indexOf(' ') >= 0 ||
                                          value.trim() == '') {
                                        return '空文字は受け付けていません。';
                                      } else if (value.indexOf('　') >= 0 ||
                                          value.trim() == '') {
                                        return '空文字は受け付けていません。';
                                      } else if (!regExp1.hasMatch(value)) {
                                        return '大文字小文字数字を含めて８文字以上入力ください';
                                      } else if (regExp2.hasMatch(value)) {
                                        return '使用できない文字が含まれています';
                                      } else if (answer != check) {
                                        return 'パスワードが違います';
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    controller: _newPassWord,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    autocorrect: false,
                                    enableInteractiveSelection: false,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      labelText: '新規パスワード',
                                      hintText: '新規パスワードを入力してください',
                                    ),
                                    validator: (value) {
                                      String pattern1 =
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                                      String pattern2 =
                                          r'^(?=.*[!-/:-@\\[-`{-~]).{1,}$';
                                      RegExp regExp1 = new RegExp(pattern1);
                                      RegExp regExp2 = new RegExp(pattern2);

                                      //確認用変数
                                      String before;
                                      String after;
                                      setState(() {
                                        before = password;
                                        after = _newPassWord.text;
                                      });

                                      if (value.isEmpty) {
                                        return '新規パスワードを入力してください。';
                                      } else if (value.indexOf(' ') >= 0 ||
                                          value.trim() == '') {
                                        return '空文字は受け付けていません。';
                                      } else if (value.indexOf('　') >= 0 ||
                                          value.trim() == '') {
                                        return '空文字は受け付けていません。';
                                      } else if (!regExp1.hasMatch(value)) {
                                        return '大文字小文字数字を含めて８文字以上入力ください';
                                      } else if (regExp2.hasMatch(value)) {
                                        return '使用できない文字が含まれています';
                                      } else if (before == after) {
                                        return '同じパスワードは使えません';
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    controller: _subPassWord,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    autocorrect: false,
                                    enableInteractiveSelection: false,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      labelText: '新規パスワード（確認）',
                                      hintText: 'もう一度新規パスワードを入力してください',
                                    ),
                                    validator: (value) {
                                      //確認用の変数
                                      String finalAnswer;
                                      String finalCheck;
                                      setState(() {
                                        finalAnswer = _subPassWord.text;
                                        finalCheck = _newPassWord.text;
                                      });

                                      if (value.isEmpty) {
                                        return 'テキストを入力してください。';
                                      } else if (value.indexOf(' ') >= 0 ||
                                          value.trim() == '') {
                                        return '空文字は受け付けていません。';
                                      } else if (value.indexOf('　') >= 0 ||
                                          value.trim() == '') {
                                        return '空文字は受け付けていません。';
                                      } else if (finalAnswer != finalCheck) {
                                        return 'パスワードが違います';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                color: Colors.white,
                                textColor: Colors.blue,
                                child: Text('キャンセル'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                              FlatButton(
                                color: Colors.white,
                                textColor: Colors.blue,
                                child: Text('OK'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    //パスワード変更
                                    setState(() {
                                      //ここに変更後のパスワードをデータベースに送信する
                                      print(password);
                                      Navigator.of(context).pop(true);
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        });
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
        ),
      ),
    );
  }
}
