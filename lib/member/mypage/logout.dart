import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../member.dart';
import 'dart:async';

class CancelMembershipPage extends StatelessWidget {
  CancelMembershipPage({Key key, this.title}) : super(key: key);

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
        body: TestPage(),
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  CMemberPage createState() => CMemberPage();
}

class CMemberPage extends State<TestPage> {
  bool _isCheck = false;

  void _handleCheckbox(bool isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
  }

  Future<void> boo() async {
    if (_isCheck == false) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("エラー"),
            content: Text("同意チェックを入れてください"),
            actions: <Widget>[
              // ボタン領域
              // FlatButton(
              //   child: Text("Cancel"),
              //   onPressed: () => Navigator.pop(context),
              // ),
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } else {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SideNavigation(),
          // VerticalDivider(thickness: 1, width: 1),

          Expanded(
            child: PostList(),
          ),

          // PostList(),
          Container(
            height: 380,
            child: Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Checkbox(
                  activeColor: Colors.blueAccent,
                  value: _isCheck,
                  onChanged: _handleCheckbox,
                ),
                Text("上記事項に同意の上、退会手続きを行います"),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: MaterialButton(
                  height: 70.0,
                  minWidth: 180.0,
                  child: Text(
                    "退会する",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.red,
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    boo();
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
                          builder: (context) => MemberPage(select: 1),
                        ));
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// class SideNavigation extends StatefulWidget {
//   @override
//   _SideNavigationState createState() => _SideNavigationState();
// }
//
// class _SideNavigationState extends State<SideNavigation> {
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return NavigationRail(
//       selectedIndex: selectedIndex,
//       onDestinationSelected: (index) {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       destinations: [
//         NavigationRailDestination(
//           icon: Icon(Icons.thumbs_up_down),
//           label: Text('ThumbsUpDown'),
//         ),
//         NavigationRailDestination(
//           icon: Icon(Icons.people),
//           label: Text('People'),
//         ),
//         NavigationRailDestination(
//           icon: Icon(Icons.face),
//           label: Text('Face'),
//         ),
//         NavigationRailDestination(
//           icon: Icon(Icons.bookmark),
//           label: Text('Bookmark'),
//         ),
//       ],
//     );
//   }
// }

// class _PostsHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: ListTile(
//             leading: ClipOval(
//               child: Container(
//                 color: Colors.grey[300],
//                 width: 48,
//                 height: 48,
//                 child: Icon(
//                   Icons.storage,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ),
//             title: Text('Posts'),
//             subtitle: Text('20 Posts'),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: ListTile(
//             leading: ClipOval(
//               child: Container(
//                 color: Colors.grey[300],
//                 width: 48,
//                 height: 48,
//                 child: Icon(
//                   Icons.style,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ),
//             title: Text('All Types'),
//             subtitle: Text(''),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _Post extends StatelessWidget {
  final String name;
  final String message;
  final String textReason;
  final Color colorPrimary;
  final Color colorPositive;
  final String textPositive;
  final Color colorNegative;
  final String textNegative;

  const _Post({
    Key key,
    this.name,
    this.message,
    this.textReason,
    this.colorPrimary,
    this.colorPositive,
    this.textPositive,
    this.colorNegative,
    this.textNegative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  // color: colorPrimary,
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green[800],
                    ),
                  ),
                ),
              ),
              title: Text(name),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 78),
                  Container(
                    width: 16,
                    height: 16,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: colorPrimary, width: 4),
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                  ),
                  SizedBox(width: 8),
                  Flexible(child: Text(message)),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   child: Row(
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //           border: Border(
            //             bottom: BorderSide(color: colorPrimary, width: 2),
            //           ),
            //         ),
            //         child: Text(
            //           textReason,
            //           style: TextStyle(color: Colors.blueAccent),
            //         ),
            //       ),
            //       SizedBox(width: 24),
            //       Expanded(
            //         child: TextButton(
            //           style: TextButton.styleFrom(
            //             primary: colorNegative,
            //           ),
            //           onPressed: () {},
            //           child: Text(textNegative),
            //         ),
            //       ),
            //       SizedBox(width: 8),
            //       Expanded(
            //         child: TextButton(
            //           style: TextButton.styleFrom(
            //             primary: colorPositive,
            //             backgroundColor: colorPositive.withOpacity(0.2),
            //           ),
            //           onPressed: () {},
            //           child: Text(textPositive),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _PostGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Post(
      name: '一度退会するとお客様の情報はすべて削除され、サービスがご利用できなくなります',
      message:
      'Once you cancel your membership, all your information will be deleted and you will no longer be able to use the service.',
      textReason: 'Report Details',
      colorPrimary: Colors.greenAccent,
      colorPositive: Colors.greenAccent,
      textPositive: 'Keep',
      colorNegative: Colors.blueAccent,
      textNegative: 'Archive',
    );
  }
}

class _PostRed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Post(
      name: '再登録しても、過去のデータは引き継げません',
      message: 'Re-registering will not transfer historical data.',
      textReason: 'Pending Reason',
      colorPrimary: Colors.deepOrangeAccent,
      colorPositive: Colors.blueAccent,
      textPositive: 'Publish',
      colorNegative: Colors.deepOrangeAccent,
      textNegative: 'Decline',
    );
  }
}

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 48),
      // child: Column(
      // mainAxisSize: MainAxisSize.min,
      // children: [
      // _PostsHeader(),
      //Expanded(child:
      child: ListView(
        children: [
          _PostGreen(),
          _PostRed(),
          // _PostGreen(),
          // _PostRed(),
          // _PostGreen(),
          // _PostRed(),
        ],
      ),
      // ),
      // ],
      // ),
    );
  }
}
