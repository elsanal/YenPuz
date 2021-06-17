//@dart=2.9
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_admob_app_open/ad_request_app_open.dart';
import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';

class Admob{

  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  Admob();
  adInit()async{
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6452396354959679~9387303536");
    await FlutterAdmobAppOpen.instance.initialize(
      appId: "ca-app-pub-6452396354959679~9387303536",
      appAppOpenAdUnitId: "ca-app-pub-6452396354959679/7209778474",
      targetingInfo: openTargetingInfo,
    );
  }


  InterstitialAd myInterstitialAd = InterstitialAd(
    adUnitId: "ca-app-pub-6452396354959679/1565487983",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  BannerAd myBannerAd = BannerAd(
    adUnitId: "ca-app-pub-6452396354959679/4047346941",
    targetingInfo: targetingInfo,
    size: AdSize.banner,
  );

    myVideoAd(){
      int _count = 0;
      videoAd..load(
        adUnitId: "ca-app-pub-6452396354959679/7209778474",
        targetingInfo: targetingInfo,
      );
      Future.delayed(Duration(seconds: 1),()=>videoAd..show());
      // videoAd.listener = videoAd.listener= (RewardedVideoAdEvent event,
      //     {required String rewardType, required int rewardAmount}) {
      //   if (event == RewardedVideoAdEvent.rewarded) {
      //     _count ++;
      //   }
      // };
    }



  AdRequestAppOpen openTargetingInfo = AdRequestAppOpen(
    keywords: <String>["game","video game","football","soccer","pandas","puzzle",
      "best game","mathematics","study","programming","Nintendo","play station",
      "virtual reality","mobile game","android game","online-game","image puzzle",
      "bourse d'etude, école, professeur, etudier, universsité, college, chaussures, habits, "
          "jeunes", "livres", "cahiers", "ordinateurs", "telephone", "riche", "entreprendre", "entreperneur",
      "jeux videos", "beauté", "argent", "tresor", "papier","electronique","machine","gratuit","etranger","apprendre"
          "immigrer", "tourismes","canada","visa","examen","developpement","carriere","reseau sociaux"],
    contentUrl: 'https://flutter.io',
    testDevices: <String>[], // Android emulators are considered test devices
    nonPersonalizedAds: true,
  );

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>["game","video game","football","soccer","pandas","puzzle",
      "best game","mathematics","study","programming","Nintendo","play station",
      "virtual reality","mobile game","android game","online-game","image puzzle",
      "bourse d'etude, école, professeur, etudier, universsité, college, chaussures, habits, "
        "jeunes", "livres", "cahiers", "ordinateurs", "telephone", "riche", "entreprendre", "entreperneur",
      "jeux videos", "beauté", "argent", "tresor", "papier","electronique","machine","gratuit","etranger","apprendre"
          "immigrer", "tourismes","canada","visa","examen","developpement","carriere","reseau sociaux"],
    contentUrl: 'https://flutter.io',
    testDevices: <String>[],
    nonPersonalizedAds: true,// Android emulators are considered test devices
  );
}