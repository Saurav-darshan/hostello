import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel_templete extends StatefulWidget {
  const Carousel_templete({super.key});

  @override
  State<Carousel_templete> createState() => _Carousel_templeteState();
}

class _Carousel_templeteState extends State<Carousel_templete> {
  final List<String> imageUrls = [
    'https://gos3.ibcdn.com/img-1697631817.jpg',
    'https://animationvisarts.com/wp-content/uploads/2017/05/airbnb-banner.jpg',
    'https://gos3.ibcdn.com/img-1697631817.jpg',
    'https://animationvisarts.com/wp-content/uploads/2017/05/airbnb-banner.jpg',
    'https://gos3.ibcdn.com/img-1697631817.jpg',
    'https://animationvisarts.com/wp-content/uploads/2017/05/airbnb-banner.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100.0,
        // enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 4 / 3,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
