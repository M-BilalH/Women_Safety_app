import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wsfty_apk/utils/quotes.dart';
import 'package:wsfty_apk/widgets/home%20widget/webview.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});
  void navigatetoRoute(BuildContext context, Widget route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.5,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: List.generate(
          imageSliders.length,
          (index) => Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                if (index == 0) {
                  navigatetoRoute(context, SafeWebView(url: "https://en.wikipedia.org/wiki/Women%27s_rights"));
                } else if (index == 1) {
                  navigatetoRoute(context, SafeWebView(url: "https://en.wikipedia.org/wiki/Women_in_the_Quran"));
                } else if (index == 2) {
                  navigatetoRoute(context, SafeWebView(url: "https://en.wikipedia.org/wiki/Wives_of_Muhammad"));
                } else {
                  navigatetoRoute(context, SafeWebView(url: "https://en.wikipedia.org/wiki/Mary_in_Islam"));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageSliders[index]),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 8,top: 110),
                      child: Center(
                        child: Text(
                          articleTitle[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
