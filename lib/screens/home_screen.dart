import 'package:flutter/material.dart';
import 'package:monetizeflutter/screens/bottom_banner_ad.dart';
import 'package:monetizeflutter/screens/inline_banner_ad.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monetize your flutter app'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomBannerAdScreen(),
                ));
              },
              child: Text('Bottom Banner Ads'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InlineBannerAdScreen(),
                ));
              },
              child: Text('Inline Banner Ads'),
            ),
          ],
        ),
      ),
    );
  }
}
