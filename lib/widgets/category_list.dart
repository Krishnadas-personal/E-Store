import 'package:e_store/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Categories extends StatefulWidget {
  final category;

  const Categories({super.key, required this.category});

  @override
  State<Categories> createState() => _CategoriesState();
}

String? _currentAddress;

class _CategoriesState extends State<Categories> {
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "Category List",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            _currentAddress ?? "",
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return item(index);
          },
          itemCount: widget.category.length,
        ),
      ]),
    );
  }

  Widget item(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductScreen.routeName,
            arguments: widget.category[index]);
      },
      child: AnimatedContainer(
        height: 55,
        width: screenWidth,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300 + (index * 200)),
        transform:
            Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index + 1}. ${widget.category[index]}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            const Icon(Icons.keyboard_arrow_right_sharp)
          ],
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 4),
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 4),
            content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        print(_currentAddress);
        print('_currentAddress*************************************');
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
