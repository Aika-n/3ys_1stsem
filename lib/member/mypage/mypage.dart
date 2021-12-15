import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginform/member/mypage/shop.dart';

import 'card.dart';
import 'coupon.dart';
import 'information.dart';
import 'logout.dart';

//マイページ
class MyPage extends StatefulWidget {
  MyPage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //前の画面に戻れなくする
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('マイページ'),
          automaticallyImplyLeading: false,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            //会員情報
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformationPage(title: '会員情報'),
                      ));
                },
                child: Container(
                  child: SizedBox.fromSize(
                    size: Size(150, 150), // button width and height
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
                              Icons.account_box_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                            // icon
                            Text("会員情報",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            // text
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            //お気に入り店舗
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TitleListCheck(title: 'チェック'),
                      ));
                },
                child: Container(
                  child: SizedBox.fromSize(
                    size: Size(150, 150), // button width and height
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
                              Icons.store_mall_directory_sharp,
                              size: 40,
                              color: Colors.white,
                            ),
                            // icon
                            Text("お気に入り店舗",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            // text
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            //使用履歴
            InkWell(
                onTap: () {},
                child: Container(
                  child: SizedBox.fromSize(
                    size: Size(150, 150), // button width and height
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
                              Icons.timer,
                              size: 40,
                              color: Colors.white,
                            ),
                            // icon
                            Text("使用履歴",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
          ]),
          //二行目
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //クーポン交換
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CouponPage(title: 'クーポン一覧'),
                        ));
                  },
                  child: Container(
                    child: SizedBox.fromSize(
                      size: Size(150, 150), // button width and height
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
                                Icons.approval,
                                size: 40,
                                color: Colors.white,
                              ),
                              // icon
                              Text("クーポン交換",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
              //クーポン確認
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardRegisterPage(title: 'カード登録'),
                        ));
                  },
                  child: Container(
                    child: SizedBox.fromSize(
                      size: Size(150, 150), // button width and height
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
                                Icons.credit_card_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              // icon
                              Text("カード登録",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
              //退会
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CancelMembershipPage(title: '退会'),
                        ));
                  },
                  child: Container(
                    child: SizedBox.fromSize(
                      size: Size(150, 150), // button width and height
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
                                Icons.logout,
                                size: 40,
                                color: Colors.white,
                              ),
                              // icon
                              Text("退会",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
