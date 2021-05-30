

import 'package:unity_ads_plugin/ad/unity_banner_ad.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

class UnityAdsManager {

  static void init(String gameId) {

    UnityAds.init(
      gameId:gameId ,//1486550
      testMode: true,
      listener: (state, args) => print('Init Listener: $state => $args'),
    );

  }
  static void loadInterstitialAd(String idtrs  ) {
    UnityAds.showVideoAd(
      placementId: idtrs,//"interstitialVideo"
      listener: (state, args) =>
          print('Rewarded Video Listener: $state => $args'),
    );
  }
  static void loadRewardedVideoAd(String idRV) {

    UnityAds.showVideoAd(
      placementId: idRV,//"rewardedVideo"
      listener: (state, args) =>
          print('Interstitial Video Listener: $state => $args'),
    );
  }
  static UnityBannerAd nativeAd(String idNativeAd) {
    return   UnityBannerAd(
        placementId: idNativeAd,//"banner"
        listener: (state, args)
        {
          print('Banner Listener: $state => $args');
        });
  }


}