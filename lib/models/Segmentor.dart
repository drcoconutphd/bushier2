import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

class Segmentor {
  static const MODEL_NAME = "bushier";

  Segmentor() {
    FirebaseModelDownloader instance = FirebaseModelDownloader.instance;

    FirebaseModelDownloadConditions conditions = FirebaseModelDownloadConditions(
      iosAllowsCellularAccess: true,
      iosAllowsBackgroundDownloading: false,
      androidChargingRequired: false,
      androidWifiRequired: false,
      androidDeviceIdleRequired: false,
    );
  }
}