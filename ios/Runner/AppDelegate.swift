import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    //    Google Maps API Key
    let mapsAPIKey = Bundle.main.infoDictionary?["MAPS_API_KEY_IOS"] as? String ?? ""
    GMSServices.provideAPIKey(mapsAPIKey)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
