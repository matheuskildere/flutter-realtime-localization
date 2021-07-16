import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutterrealtimelocalization/app/controller/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraPosition _inital =
      CameraPosition(target: LatLng(-23.52301576940105, -46.53657805244674));
  final startController = TextEditingController();
  final destinationController = TextEditingController();
  final controller = HomeController();
  late GoogleMapController mapController;
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    _inital = await controller.initialLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              polylines: Set<Polyline>.of(controller.polylines.values),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: _inital,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            Container(
              height: 144,
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              padding: EdgeInsets.all(21),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF434343)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextField(
                        controller: startController,
                        decoration: InputDecoration(
                            hintText: "Localização atual",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            contentPadding: EdgeInsets.only(left: 14)),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextField(
                        controller: destinationController,
                        decoration: InputDecoration(
                            hintText: "Destino",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            contentPadding: EdgeInsets.only(left: 14)),
                      )),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: InkWell(
          onTap: () async {
            final startLongitude = double.parse(startController.text.split(',')[1]);
            final startLatitude = double.parse(startController.text.split(',')[0]);
            final destinationLatitude = double.parse(destinationController.text.split(',')[0]);
            final destinationLongitude = double.parse(destinationController.text.split(',')[1]);
            await controller.createPolylines(startLatitude,startLongitude,
                destinationLatitude, destinationLongitude);
            mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(startLatitude, startLongitude),
      zoom: 18.0,)
            ));
            setState(() {});
          },
          child: Container(
            height: 46,
            width: 174,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF434343)),
            child: Center(
                child: Text(
              "Iniciar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
          ),
        ),
      ),
    );
  }
}
