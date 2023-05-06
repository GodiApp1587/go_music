import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:vibe_music/main.dart';
import 'package:vibe_music/screens/MainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _visible = false;
 // AppOpenAd? appOpenAd;
  //loadAppOpenAd(){
    //AppOpenAd.load(
      //  adUnitId: Platform.isAndroid
        //    ? 'ca-app-pub-2361280395457206/928374223'
          //  : 'ca-app-pub-2361280395457206/1067717585',
       // request: AdRequest(),
       // adLoadCallback: AppOpenAdLoadCallback(
         //   onAdLoaded: (ad){
           //   appOpenAd=ad;
             // appOpenAd!.show();
          //  },
           // onAdFailedToLoad: (error){
             // print(error);
           // }),
       // orientation: AppOpenAd.orientationPortrait);
 // }

  @override
  void initState() {
    super.initState();
  //  loadAppOpenAd();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Timer(
      const Duration(seconds: 5),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String imagePath = isDark
        ? 'assets/images/like.png'
        : 'assets/images/splash_light.png';

    return Scaffold(

      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: Image.asset(
            imagePath,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}