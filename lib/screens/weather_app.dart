import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import '../widgets/single_weather.dart';
import '../models/weather_locations.dart';
import '../widgets/slider_dot.dart';
import '../widgets/buildin_transform.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentpage = 0;
  String bgImg;

  _onPageChange(int index) {
    setState(() {
      _currentpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentpage].weatherType == 'Sunny') {
      bgImg = 'assets/sunny.jpg';
    } else if (locationList[_currentpage].weatherType == 'Night') {
      bgImg = 'assets/night.jpg';
    } else if (locationList[_currentpage].weatherType == 'Cloudy') {
      bgImg = 'assets/cloudy.jpeg';
    } else if (locationList[_currentpage].weatherType == 'Rainy') {
      bgImg = 'assets/rainy.jpg';
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, size: 30, color: Colors.white),
        ),
        actions: [
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: GestureDetector(
                onTap: () => print("Menu Clicked"),
                child: SvgPicture.asset(
                  'assets/menu.svg',
                  height: 38,
                  width: 38,
                  color: Colors.white,
                ),
              ))
        ],
        // centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgImg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            Container(
              margin: EdgeInsets.only(top: 140, left: 20),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentpage) SliderDot(true) else SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
                scrollDirection: Axis.horizontal,
                onPageChanged: _onPageChange,
                viewportFraction: 0.8,
                transformer: ZoomOutPageTransformer(),
                itemCount: locationList.length,
                itemBuilder: (ctx, i) => SingleWeather(i)),
            // SingleWeather()
          ],
        ),
      ),
    );
  }
}
