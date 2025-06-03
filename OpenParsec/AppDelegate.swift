import UIKit
import GameController

@main
class AppDelegate:UIResponder, UIApplicationDelegate
{
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    UTMViewControllerPatches.patchAll()

    // Start controller discovery
    GCController.startWirelessControllerDiscovery(completionHandler: nil)

    // Log connected controllers
    NotificationCenter.default.addObserver(
        forName: .GCControllerDidConnect,
        object: nil,
        queue: .main
    ) { notification in
        if let controller = notification.object as? GCController {
            print("🎮 Controller connected: \(controller.vendorName ?? "Unknown")")
        }
    }

    return true
}

	func application(_ application:UIApplication, configurationForConnecting connectingSceneSession:UISceneSession, options:UIScene.ConnectionOptions) -> UISceneConfiguration
	{
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application:UIApplication, didDiscardSceneSessions sceneSessions:Set<UISceneSession>)
	{
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}

	func applicationWillTerminate(_ application: UIApplication)
	{
		CParsec.destroy()
	}
}
