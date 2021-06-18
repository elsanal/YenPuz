//@dart=2.9
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_admob_app_open/ad_request_app_open.dart';
import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob{

  Admob();
  adInit()async{
    MobileAds.instance.initialize();
    await FlutterAdmobAppOpen.instance.initialize(
      appId: "ca-app-pub-6452396354959679~9387303536",
      appAppOpenAdUnitId: "ca-app-pub-6452396354959679/7209778474",
      targetingInfo: openTargetingInfo,
    );
  }


  myInterstitialAd(){
    RewardedAd myReward;
    RewardedAd.load(
        adUnitId: "ca-app-pub-6452396354959679/1565487983",
        request: _adRequest,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            ad.show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem){
              print("Thank you for watching");
            });
            // Keep a reference to the ad so you can show it later.
            myReward = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
    Future.delayed(Duration(milliseconds: 500),(){
      myReward.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) =>
            print("video showed"),
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
      );
    });
  }

  BannerAd myBannerAd = BannerAd(
    adUnitId: "ca-app-pub-6452396354959679/4047346941",
    request: _adRequest,
    size: AdSize.smartBanner,
    listener: BannerAdListener(),
  );

    myVideoAdLoading(){

      RewardedAd myReward;
      RewardedAd.load(
          adUnitId: "ca-app-pub-6452396354959679/7209778474",
          request: _adRequest,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (RewardedAd ad) {
      print('$ad loaded.');
      ad.show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem){
        print("Thank you for watching");
      });
      // Keep a reference to the ad so you can show it later.
      myReward = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
      print('RewardedAd failed to load: $error');
      },
      ));
      Future.delayed(Duration(milliseconds: 500),(){
        myReward.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) =>
              print("video showed"),
          onAdDismissedFullScreenContent: (RewardedAd ad) {
            print('$ad onAdDismissedFullScreenContent.');
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
          },
          onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
        );
      });
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

  static const AdRequest _adRequest = AdRequest(
    keywords: <String>["game","video game","football","soccer","pandas","puzzle",
      "best game","mathematics","study","programming","Nintendo","play station",
      "virtual reality","mobile game","android game","online-game","image puzzle",
      "bourse d'etude, école, professeur, etudier, universsité, college, chaussures, habits, "
        "jeunes", "livres", "cahiers", "ordinateurs", "telephone", "riche", "entreprendre", "entreperneur",
      "jeux videos", "beauté", "argent", "tresor", "papier","electronique","machine","gratuit","etranger","apprendre"
          "immigrer", "tourismes","canada","visa","examen","developpement","carriere","reseau sociaux"],
    contentUrl: 'https://flutter.io',
    nonPersonalizedAds: true,// Android emulators are considered test devices
  );
}