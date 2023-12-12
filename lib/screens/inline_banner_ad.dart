import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:monetizeflutter/ad_helper.dart';

class InlineBannerAdScreen extends StatefulWidget {
  const InlineBannerAdScreen({Key? key}) : super(key: key);

  @override
  State<InlineBannerAdScreen> createState() => _InlineBannerAdScreenState();
}

class _InlineBannerAdScreenState extends State<InlineBannerAdScreen> {
  List<dynamic> items = [];
  List<BannerAd> allBannerAds = [];

  SizedBox getBannerAd() {
    BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              print("Banner ad loaded successfully");
            });
          },
          onAdFailedToLoad: (ad, error) {
            print("Failed to load Banner ad : ${error.message}");
            ad.dispose();
          },
        ),
        request: AdRequest());
    bannerAd.load();
    allBannerAds.add(bannerAd);
    return SizedBox(
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
      child: AdWidget(ad: bannerAd),
    );
  }

  @override
  void initState() {
    for (int i = 1; i <= 20; i++) {
      items.add("item no $i");
    }
    for (int i = 1; i <= 3; i++) {
      int randomAdPosition = Random().nextInt(items.length);
      SizedBox bannerAd = getBannerAd();
      items.insert(randomAdPosition, bannerAd);
    }
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < allBannerAds.length; i++) {
      allBannerAds[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inline Banner'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          dynamic data = items[index];
          if (data is SizedBox) {
            return data;
          } else {
            return ListTile(
              leading: Icon(Icons.photo),
              title: Text(data.toString()),
            );
          }
        },
      ),
    );
  }
}
