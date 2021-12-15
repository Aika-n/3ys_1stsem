import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginform/member.dart';
import 'package:loginform/member/mypage/mypage.dart';
import 'package:loginform/member/timer/timer.dart';

int count = 0;

class Use4 extends StatelessWidget {
  Use4({Key key, this.title}) : super(key: key);

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
            child: Column(children: <Widget>[
          Card(
            color: Colors.cyan,
            child: ListTile(
              leading: Icon(
                Icons.credit_card,
                color: Colors.white,
                size: 72,
              ),
              title: Text(
                "決済方法",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              subtitle: Text(
                "クレジットカード",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              isThreeLine: true,
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          Card(
            color: Colors.lightBlueAccent,
            child: ListTile(
              leading: Icon(
                Icons.confirmation_num_outlined,
                color: Colors.white,
                size: 72,
              ),
              title: Text(
                "クーポン",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              subtitle: Text(
                "100円引き",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              isThreeLine: true,
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          Card(
            color: Colors.blue,
            child: ListTile(
              leading: Icon(
                Icons.water_damage_sharp,
                color: Colors.white,
                size: 72,
              ),
              title: Text(
                "洗濯機",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              subtitle: Text(
                "ECC１号店",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              isThreeLine: true,
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          Card(
            color: Colors.deepPurpleAccent,
            child: ListTile(
              leading: Icon(
                Icons.timelapse,
                color: Colors.white,
                size: 72,
              ),
              title: Text(
                "コース",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              subtitle: Text(
                "通常コース/30分200円",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              isThreeLine: true,
              contentPadding: EdgeInsets.all(10.0),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    height: 70.0,
                    minWidth: 180.0,
                    child: Text(
                      "洗濯開始",
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
                            builder: (context) => TimerPage(title: '稼働状況'),
                          ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: MaterialButton(
                      height: 70.0,
                      minWidth: 180.0,
                      child: Text(
                        "戻る",
                        style: TextStyle(color: Colors.black),
                      ),
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
        ])),
      ),
    );
  }
}
