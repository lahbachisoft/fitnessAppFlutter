import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class MyFacebookAdsManager {
  static bool isInterstitialAdLoaded = false;
  static bool _isInterstitialAdLoaded = false;
  static bool _isRewardedAdLoaded = false;
  static bool _isRewardedVideoComplete = false;
  static void init(String idinit,String idtrs,String idRV) {
  //  adsInterstitialUnitId = id;
    FacebookAudienceNetwork.init(
      testingId: idinit,
    );
    _loadInterstitialAd(idtrs);
    _loadRewardedVideoAd(idRV);
   // loadNewFANInterstitialAd();
  }
  static void _loadInterstitialAd(String idtrs  ) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: idtrs, //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd(idtrs);
        }
      },
    );
  }
  static void _loadRewardedVideoAd(String idRV) {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
          _isRewardedVideoComplete = true;

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd(idRV);
        }
      },
    );
  }
  static void  showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }

  static void showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else
      print("Rewarded Ad not yet loaded!");
  }
  static FacebookBannerAd fbBannerAd() {
    return FacebookBannerAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047",
      // Platform.isAndroid ? "YOUR_ANDROID_PLACEMENT_ID" : "YOUR_IOS_PLACEMENT_ID",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            print("Error: $value");
            break;
          case BannerAdResult.LOADED:
            print("Loaded: $value");
            break;
          case BannerAdResult.CLICKED:
            print("Clicked: $value");
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            print("Logging Impression: $value");
            break;
        }
      },

    );
  }
  static FacebookNativeAd nativeAd(width,height, idNativeAd) {
    return FacebookNativeAd(
     placementId: idNativeAd,//"IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650"
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width:width,
      height: height,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

}