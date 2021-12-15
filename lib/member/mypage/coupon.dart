import 'package:flutter/material.dart';
import 'package:loginform/member.dart';
import 'package:loginform/member/mypage/mypage.dart';

int Pt = 300;

class CouponPage extends StatefulWidget {
  CouponPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  //クーポン交換ダイアログ
  void exchange(st) {
    setState(() {
      int.parse(st);
      if (int.parse(st) >= Pt) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("メッセージ"),
              content: Text("ポイントが不足しています"),
              actions: <Widget>[
                // ボタン領域

                TextButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("メッセージ"),
              content: Text("交換しますか？"),
              actions: <Widget>[
                // ボタン領域
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text("OK"),
                  //追加処理必要（所持ポイントのマイナス処理）
                  onPressed: () {
                    setState(() {
                      Pt = Pt - 100;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('クーポン'),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            padding: EdgeInsets.only(top: 48),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //現在所持ポイント
                ListTile(
                  leading: ClipOval(
                    child: Container(
                      color: Colors.grey[300],
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.approval,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  title: Text('所持ポイント'),
                  subtitle: Text('$Pt Point'),
                ),
                ListView(
                  shrinkWrap: true, //追加（Columnの中でListViewを使うとエラーが発生するため）
                  physics: const NeverScrollableScrollPhysics(), //追加
                  //クーポン一覧
                  children: [
                    //100円クーポン
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: ClipOval(
                                child: Container(
                                  color: Colors.deepOrangeAccent,
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: Icon(
                                    Icons.redeem,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              title: Text("100円引きクーポン"),
                              trailing: ElevatedButton(
                                child: const Text('交換'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlueAccent,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  exchange("100");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 72),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.deepOrangeAccent,
                                          width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(child: Text("必要ポイント：100Pt"
                                      "\n")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //300円クーポン
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: ClipOval(
                                child: Container(
                                  color: Colors.yellow,
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: Icon(
                                        Icons.redeem,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              title: Text("300円引きクーポン"),
                              trailing: ElevatedButton(
                                child: const Text('交換'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlueAccent,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  exchange("100");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 72),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.yellow,
                                          width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(child: Text("必要ポイント：250Pt"
                                      "\n")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //500円クーポン
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: ClipOval(
                                child: Container(
                                  color: Colors.greenAccent,
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: Icon(
                                    Icons.redeem,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              title: Text("500円引きクーポン"),
                              trailing: ElevatedButton(
                                child: const Text('交換'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlueAccent,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  exchange("500");
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 72),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.greenAccent, width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Flexible(child: Text("必要ポイント：400Pt"
                                      "\n")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //ホームに戻るボタン
                Padding(
                  padding: EdgeInsets.only(top: 140),
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
          )),
    );
  }
}
