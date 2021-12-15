import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loginform/member/timer/complete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math' as math;

class TimerPage extends StatefulWidget {
  TimerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  // インスタンス生成
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Timer _timer; // この辺が状態
  DateTime _time;
  DateTime _stopTime;

  //サーバーから時間持ってくる
  int washTime = 0;

  //通知


  void _start() {
    _timer = Timer.periodic(
      Duration(seconds: 1), // 1秒毎に定期実行
          (Timer timer) {
        setState(() {
          // 変更を画面に反映するため、setState()している
          _time = _time.add(Duration(seconds: -1));
        });
        if (_time == _stopTime) {
          if (_timer != null && _timer.isActive) {
            // 一度だけ音を鳴らす
            FlutterRingtonePlayer.playNotification();
            //_scheduleLocalNotification();
            _timer.cancel();
            //ダイアログボックス
            showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: Text("登録完了"),
                  content: const Text("洗濯が終了しました！"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("閉じる"),
                      onPressed: () {
                        //画面遷移
                        Navigator.of(context).pop(true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompletePage(title: "洗濯完了"),
                            ));
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  void initState() {
    // 初期処理
    washTime = 10;
    _time = DateTime.utc(0, 0, 0).add(Duration(seconds: washTime));
    _stopTime = DateTime.utc(0, 0, 0);
    if (washTime > 0) {
      _start();
    }
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                  Container(
                    child: SizedBox.fromSize(
                      size: Size(300, 150), // button width and height
                      child: ClipRRect(
                        //角を丸める
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        //角の調整
                        child: Material(
                          color: Colors.red, // button color
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.shop,
                                size: 40,
                                color: Colors.white,
                              ),
                              //ここにお店の名前を書く
                              Text("御堂筋点",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("洗濯完了まで"),
                        Text(
                          DateFormat.Hms().format(_time),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
