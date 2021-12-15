import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class EntryPage extends StatefulWidget {
  EntryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  //キー
  final _formKey = GlobalKey<FormState>();

  //キーボード
  final _userName = TextEditingController();
  final _mailAddress = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  final _subPassWord = TextEditingController();

  //リスト
  static const genderList = <String>[
    "男",
    "女",
    "選択しない",
  ];
  static const ageList = <String>[
    "10代",
    "20代",
    "30代",
    "40代",
    "50代",
    "60代",
    "70代",
  ];

  //クーポン用ドロップダウンリスト
  final List<DropdownMenuItem<String>> _genderDownMenuItems = genderList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  //支払い方法用ドロップダウンリスト
  final List<DropdownMenuItem<String>> _ageDownMenuItems = ageList
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  //value用
  String _genderSelectedVal;
  String _ageSelectedVal;

  //サーバーに送る用の変数
  int randumNumbers;
  String gender;
  String age;
  String userName;
  String mailAddress;
  String phoneNumber;
  String password;

  //会員番号用の変数
  int memberCount = 0;

  //ローカル変数エリア
  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      memberCount = prefs.getInt('counter') ?? 0;
    });
  }

  // Shared Preferenceにデータを書き込む
  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    prefs.setInt('counter', memberCount);
  }

  // Shared Preferenceのデータを削除する
  _removePrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      memberCount = 0;
      // 以下の「counter」がキー名。
      prefs.remove('counter');
    });
  }

  //初期に読み込まれる関数
  @override
  void initState() {
    super.initState();
    // 初期化時にShared Preferencesに保存している値を読み込む
    _getPrefItems();
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
        body: Form(
          key: _formKey, // 作成したフォームキーを指定
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.only(top: 80, right: 20, bottom: 20, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //名前入力
                  TextFormField(
                    controller: _userName,
                    obscureText: false,
                    autocorrect: true,
                    enableInteractiveSelection: true,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'ユーザー名',
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
                  //性別＆年齢層
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton(
                        value: _genderSelectedVal,
                        hint: const Text('年齢を選んでください'),
                        onChanged: (String newValue) => {
                          setState(() {
                            _genderSelectedVal = newValue;
                            gender = _genderSelectedVal;
                          }),
                        },
                        items: _genderDownMenuItems,
                      ),
                      DropdownButton(
                        value: _ageSelectedVal,
                        hint: const Text('性別を選んでください'),
                        onChanged: (String newValue) => {
                          setState(() {
                            _ageSelectedVal = newValue;
                            age = _ageSelectedVal;
                          }),
                        },
                        items: _ageDownMenuItems,
                      ),
                    ],
                  ),
                  //メールアドレス
                  TextFormField(
                    controller: _mailAddress,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    autocorrect: true,
                    enableInteractiveSelection: true,
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'メールアドレス',
                      icon: Icon(Icons.email_rounded),
                    ),
                    validator: (value) {
                      const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                      final regExp = RegExp(pattern);
                      if (value.isEmpty) {
                        return 'テキストを入力してください。';
                      } else if (value.indexOf(' ') >= 0 ||
                          value.trim() == '') {
                        return '空文字は受け付けていません。';
                      } else if (value.indexOf('　') >= 0 ||
                          value.trim() == '') {
                        return '空文字は受け付けていません。';
                      } else if (!regExp.hasMatch(value)) {
                        return 'no';
                      }
                    },
                  ),
                  //電話番号
                  TextFormField(
                    controller: _phoneNumber,
                    keyboardType: TextInputType.phone,
                    //数字以外打てない
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    obscureText: false,
                    autocorrect: false,
                    enableInteractiveSelection: false,
                    maxLength: 9,
                    decoration: InputDecoration(
                      labelText: '電話番号',
                      icon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'テキストを入力してください。';
                      } else if (value.indexOf(' ') >= 0 ||
                          value.trim() == '') {
                        return '空文字は受け付けていません。';
                      } else if (value.indexOf('　') >= 0 ||
                          value.trim() == '') {
                        return '空文字は受け付けていません。';
                      } else if (value.length < 9) {
                        return '9文字入力してください';
                      }
                    },
                  ),
                  //パスワード
                  TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    autocorrect: false,
                    enableInteractiveSelection: false,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      hintText: '大文字小文字数字を含めて８文字以上入力ください',
                      icon: Icon(Icons.https),
                    ),
                    validator: (value) {
                      String pattern1 =
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                      String pattern2 = r'^(?=.*[!-/:-@\\[-`{-~]).{1,}$';
                      RegExp regExp1 = new RegExp(pattern1);
                      RegExp regExp2 = new RegExp(pattern2);

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
                      }
                    },
                  ),
                  //パスワード確認用
                  TextFormField(
                    controller: _subPassWord,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    autocorrect: false,
                    enableInteractiveSelection: false,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'パスワード確認用',
                      icon: Icon(Icons.done),
                    ),
                    validator: (value) {
                      //確認用の変数
                      String answer;
                      String check;
                      setState(() {
                        answer = _password.text;
                        check = _subPassWord.text;
                      });

                      if (value.isEmpty) {
                        return 'テキストを入力してください。';
                      } else if (value.indexOf(' ') >= 0 ||
                          value.trim() == '') {
                        return '空文字は受け付けていません。';
                      } else if (value.indexOf('　') >= 0 ||
                          value.trim() == '') {
                        return '空文字は受け付けていません。';
                      } else if (answer != check) {
                        return 'パスワードが違います';
                      }
                    },
                  ),
                  //送信エリア
                  Padding(
                    padding: EdgeInsets.only(
                        top: 80, right: 20, bottom: 20, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //登録ボタン
                        MaterialButton(
                          height: 70.0,
                          minWidth: 180.0,
                          child: Text(
                            "登録",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          color: Colors.blue,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () async {
                            try{
                              // バリデーションチェック
                              if (_formKey.currentState.validate()) {
                                var rand = new Random();
                                var next = rand.nextDouble() * 100000;
                                while (next < 100000) {
                                  next *= 10;
                                }

                                setState(() {
                                  memberCount++;
                                  _setPrefItems();  // Shared Preferenceに値を保存する。
                                  randumNumbers = next.toInt();
                                  userName = _userName.text;
                                  mailAddress = _mailAddress.text;
                                  phoneNumber = _phoneNumber.text;
                                  int.parse(phoneNumber);
                                  password = _password.text;
                                });

                                //デバッグ
                                print(memberCount);
                                //この項目をサーバーに送る
                                print(randumNumbers);
                                print(userName);
                                print(gender);
                                print(age);
                                print(mailAddress);
                                print(phoneNumber);
                                print(password);

                                //ここにサーバーに送る処理書くと思う！（多分）

                                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mailAddress, password: password);

                                //ダイアログボックス
                                await showDialog<bool>(
                                  context: context,
                                  barrierDismissible: false, // 追加
                                  builder: (BuildContext context) {
                                    return new AlertDialog(
                                      title: Text("登録完了"),
                                      content: const Text("ログインページに戻ります"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("戻る"),
                                          onPressed: () {
                                            //画面遷移
                                            Navigator.of(context).pop(true);
                                            Navigator.of(context)
                                                .popAndPushNamed("/");
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } catch (e) {
                              //ダイアログボックス
                              await showDialog<bool>(
                                context: context,
                                barrierDismissible: false, // 追加
                                builder: (BuildContext context) {
                                  return new AlertDialog(
                                    title: Text("登録失敗"),
                                    content: const Text("登録失敗しました"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("戻る"),
                                        onPressed: () {
                                          //画面遷移
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                        MaterialButton(
                          height: 70.0,
                          minWidth: 180.0,
                          child: Text(
                            "キャンセル",
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                          color: Colors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed("/");
                            //ここ提出時消すこと
                            _removePrefItems();
                            print(memberCount);
                          },
                        ),
                      ],
                    ),
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
