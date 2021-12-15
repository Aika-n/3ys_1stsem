import 'package:flutter/material.dart';
import 'package:loginform/member/home/use1.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  // <- (※1)
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
                children: [
                  Container(
                    child: SizedBox.fromSize(
                      size: Size(400, 300), // button width and height
                      child: ClipRRect(
                        //角を丸める
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        //角の調整
                        child: Material(
                          color: Colors.red, // button color
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.water_damage_sharp,
                                size: 150,
                                color: Colors.white,
                              ),
                              Text("ここでは洗濯機を利用する事が出来ます",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              Text("（洗濯機に洗濯物を入れてください）",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: MaterialButton(
                      height: 70.0,
                      minWidth: 180.0,
                      child: Text(
                        "洗濯機を利用する",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      color: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Use1(title: '支払い方法'),
                            ));
                      },
                    ),
                  ),
                ]),
          )),
    );
  }
}
