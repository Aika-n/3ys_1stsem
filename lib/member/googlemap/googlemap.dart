import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:loginform/member/mypage/shop.dart';

class GoogleMaps extends StatefulWidget {
  GoogleMaps({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Location _locationService = Location();

  // 現在位置
  LocationData _yourLocation;

  // 現在位置の監視状況
  StreamSubscription _locationChangedListen;

  @override
  void initState() {
    super.initState();

    // 現在位置の取得
    _getLocation();

    // 現在位置の変化を監視
    _locationChangedListen =
        _locationService.onLocationChanged.listen((LocationData result) async {
      setState(() {
        _yourLocation = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // 監視を終了
    _locationChangedListen?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('マップ'),
          automaticallyImplyLeading: false,
        ),
        body: _makeGoogleMap(),
      ),
    );
  }

  Widget _makeGoogleMap() {
    if (_yourLocation == null) {
      // 現在位置が取れるまではローディング中
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Google Map ウィジェットを返す
      return GoogleMap(
        // 初期表示される位置情報を現在位置から設定
        initialCameraPosition: CameraPosition(
          target: LatLng(_yourLocation.latitude, _yourLocation.longitude),
          zoom: 18.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId('marker_1'),
                position: LatLng(34.7064324, 135.5032228),
                infoWindow: InfoWindow(
                  title: "ECC店",
                  snippet: 'タップすると店の情報が開きます',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopPage(title: 'ECC1号店'),
                        ));
                  },
                ),
              ),
            );
          });
        },

        // 現在位置にアイコン（青い円形のやつ）を置く
        myLocationEnabled: true,
      );
    }
  }

  void _getLocation() async {
    _yourLocation = await _locationService.getLocation();
  }
}
