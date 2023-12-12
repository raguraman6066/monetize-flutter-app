import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:monetizeflutter/ad_helper.dart';

class BottomBannerAdScreen extends StatefulWidget {
  const BottomBannerAdScreen({Key? key}) : super(key: key);

  @override
  State<BottomBannerAdScreen> createState() => _BottomBannerAdScreenState();
}

class _BottomBannerAdScreenState extends State<BottomBannerAdScreen> {
  late BannerAd bottomBannerAd;
  bool isBannerAdLoaded = false;

  @override
  void initState() {
    loadBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    bottomBannerAd.dispose();
    super.dispose();
  }

  Future loadBannerAd() async {
    bottomBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print("Failed to load banner ad : ${error.message}");
          ad.dispose();
        }),
        request: AdRequest());
    bottomBannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Banner Ads'),
        ),
        body: const Center(
          child: Text('Bottom Banner Ad'),
        ),
        bottomNavigationBar: isBannerAdLoaded
            ? SizedBox(
                width: bottomBannerAd.size.width.toDouble(),
                height: bottomBannerAd.size.height.toDouble(),
                child: AdWidget(ad: bottomBannerAd),
              )
            : const LinearProgressIndicator());
  }
}
