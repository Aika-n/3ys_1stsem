import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginform/member/googlemap/googlemap.dart';
import 'package:loginform/member/home/home.dart';
import 'package:loginform/member/mypage/mypage.dart';

import 'member/timer/timer.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key, this.select}) : super(key: key);

  int select;

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  // アイコン情報
  static const _footerIcons = [
    Icons.home,
    Icons.map,
    Icons.account_box_sharp,
  ];

  // アイコン文字列
  static const _footerItemNames = [
    'ホーム',
    'マップ',
    'マイページ',
  ];

  var _routes = [
    HomePage(title: 'ホーム'),
    GoogleMaps(title: 'マップ'),
    MyPage(title: 'マイページ'),
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _footerItemNames.length; i++) {
      if(i == widget.select) {
        _bottomNavigationBarItems.add(_UpdateActiveState(widget.select));
      } else {
        _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
      }
    }
  }

  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.blue,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black87,
          ),
        ));
  }

  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        ));
  }

  //最初の処理
  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[widget.select] =
          _UpdateDeactiveState(widget.select);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
      widget.select = index;
    });
  }

  //下のバー
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(widget.select),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
