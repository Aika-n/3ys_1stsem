import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login/entry.dart';
import 'member.dart';
import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupTimeZone();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// タイムゾーンを設定する
Future<void> _setupTimeZone() async {
  tz.initializeTimeZones();
  var tokyo = tz.getLocation('Asia/Tokyo');
  tz.setLocalLocation(tokyo);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'マモレール',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(title: 'ログイン'),
        '/entry': (context) => EntryPage(title: '新規登録'),
        '/member': (context) => MemberPage(select: 0),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //フォームキー（正規表現用）
  final _formKey = GlobalKey<FormState>();

  //キーボード用の変数
  final _mailAddress = TextEditingController();
  final _password = TextEditingController();

  //ログイン用の変数
  String mailAddress;
  String password;

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
          child: Card(
            elevation: 4.0,
            margin: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //タイトル
                  Container(
                    // 内側の余白（パディング）
                    padding: EdgeInsets.all(5),
                    // 外側の余白（マージン）
                    //margin: EdgeInsets.all(5),
                    child: Image.asset('images/mamoreru.png'),
                  ),
                  //入力＆ログインボタン
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
                              return 'メールアドレスを入力してください。';
                            } else if (value.indexOf(' ') >= 0 ||
                                value.trim() == '') {
                              return '空文字は受け付けていません。';
                            } else if (value.indexOf('　') >= 0 ||
                                value.trim() == '') {
                              return '空文字は受け付けていません。';
                            } else if (!regExp.hasMatch(value)) {
                              return '正しく入力してください';
                            }
                          },
                        ),
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: 80, right: 10, bottom: 30, left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MaterialButton(
                                  height: 70.0,
                                  minWidth: 180.0,
                                  child: Text(
                                    "ログイン",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blue,
                                  shape: const StadiumBorder(
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    try {
                                      // バリデーションチェック
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          mailAddress = _mailAddress.text;
                                          password = _password.text;
                                        });

                                        //デバッグ
                                        print(mailAddress);
                                        print(password);

                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: mailAddress,
                                                password: password);

                                        //画面遷移
                                        await Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                            return MemberPage(select: 0);
                                          }),
                                        );
                                      }
                                    } catch (e) {
                                      //ダイアログボックス
                                      await showDialog<bool>(
                                        context: context,
                                        barrierDismissible: false, // 追加
                                        builder: (BuildContext context) {
                                          return new AlertDialog(
                                            title: Text("ログイン失敗"),
                                            content: const Text("ログイン失敗しました"),
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
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //新規ボタン＆説明ボタン
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 90.0),
                    child: Row(
                      // 1行目
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //新規ボタン
                        MaterialButton(
                          height: 70.0,
                          minWidth: 150.0,
                          child: Text(
                            "新規登録",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/entry');
                          },
                        ),

                        //説明ボタン
                        MaterialButton(
                          height: 70.0,
                          minWidth: 150.0,
                          child: Text(
                            "アプリ説明",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  title: Text("アプリ説明"),
                                  content: const Text(
                                      'この作品はアプリを介してコインランドリーを効率よく安全に利用することができます。\n'
                                      'このアプリを利用するにあたって以下の登録が必要となります\n'
                                      '\n'
                                      '・ユーザー名\n'
                                      '・性別\n'
                                      '・年代\n'
                                      '・メールアドレス\n'
                                      '・電話番号\n'
                                      '・パスワード\n'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
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
