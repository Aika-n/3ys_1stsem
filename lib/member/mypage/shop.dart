import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../member.dart';

bool favorite;
List _titleList = [empty];
var empty = '空';
var ecc = 'ECC1号店';

//店舗情報
class ShopPage extends StatefulWidget {
  ShopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //スナックキー用
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //スナックバー
  void _deleteshowbar() {
    _key.currentState.showSnackBar(const SnackBar(content: Text('解除しました')));
  }

  void _registershowbar() {
    _key.currentState.showSnackBar(const SnackBar(content: Text('登録しました')));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: 550,
                height: 800,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      offset: Offset(-10, -10),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 90,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Icon(
                    favorite == true ? Icons.favorite : Icons.favorite_border,
                    color: favorite == true ? Colors.red : Colors.black38,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 100,
                width: 550,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "ECC1号店",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 300,
                width: 90,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    border: Border(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Icon(Icons.water_damage_sharp),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 300,
                width: 550,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    border: Border(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "洗濯機：1台",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 550,
                width: 90,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Icon(Icons.phone),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 550,
                width: 550,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "0120-090-546",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 800,
                width: 90,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    border: Border(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Icon(Icons.store_mall_directory_sharp),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 800,
                width: 550,
                child: Container(
                  alignment: Alignment.center,
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    border: Border(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "〒530-0015"
                        "\n大阪市北区中崎西2丁目3番35号"
                        "\n(JR/大阪駅御堂筋口より徒歩10分)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 600,
                width: 550,
                child: MaterialButton(
                  height: 70.0,
                  minWidth: 180.0,
                  child: Text(
                    "お気に入り登録",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      if (favorite != true) {
                        setState(() {
                          favorite = true;
                          _titleList.add(ecc);
                          _titleList.remove(empty);
                          _registershowbar();
                          debugPrint('ON');
                        });
                      } else {
                        setState(() {
                          favorite = false;
                          _titleList.remove(ecc);
                          _titleList.add(empty);
                          _deleteshowbar();
                          debugPrint('OFF');
                        });
                      }
                    });
                  },
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  height: 730,
                  width: 550,
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

//_titleListの中身を判断
class TitleListCheck extends StatelessWidget {
  TitleListCheck({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return (() {
      if (_titleList[0] == empty) {
        return EmptyPage(title: 'お気に入り店舗');
      } else {
        return ShopList(title: 'お気に入り店舗');
      }
    })();
  }
}

//_titleList[]の中身がある場合
class ShopList extends StatefulWidget {
  ShopList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('お気に入りリスト'),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: _titleList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(_titleList[index]),
                      onTap: () {
                        if (_titleList[index] == ecc) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopPage(title: 'ECC1号店'),
                              ));
                        }
                      },
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 400),
                      child: MaterialButton(
                        height: 70.0,
                        minWidth: 180.0,
                        child: Text(
                          "店を探す",
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
                                builder: (context) => MemberPage(select: 1),
                              ));
                        },
                      ),
                    ),
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
                );
              }),
        ),
      ),
    );
  }
}

//_titleList[]の中身が空の場合
class EmptyPage extends StatelessWidget {
  EmptyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('お気に入りリスト'),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 250),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 100),
                      child: Container(
                          color: Colors.red,
                          width: 450,
                          height: 350,
                          transform: Matrix4.rotationZ(0.1),
                          child: Center(
                            child: Text(
                              "お気に入り店舗がありません",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  MaterialButton(
                    height: 70.0,
                    minWidth: 180.0,
                    child: const Text(
                      "店を探す",
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
                            builder: (context) => MemberPage(select: 1),
                          ));
                    },
                  ),
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
            )));
  }
}
