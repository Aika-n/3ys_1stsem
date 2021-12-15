import 'package:flutter/material.dart';

import '../../member.dart';

class CompletePage extends StatelessWidget {
  CompletePage({Key key, this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: SizedBox.fromSize(
                  size: Size(550, 300), // button width and height
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
                            Icons.check_circle_outline,
                            size: 50,
                            color: Colors.white,
                          ),
                          Text("洗濯完了！",
                              style: TextStyle(
                                  fontSize: 30, color: Colors.white)),
                          Text("\n"),
                          Text("忘れ物がないようお帰りください",
                              style: TextStyle(
                                  fontSize: 30, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberPage(select: 0),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
