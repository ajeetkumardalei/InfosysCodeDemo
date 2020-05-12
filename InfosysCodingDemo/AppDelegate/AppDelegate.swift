

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        setSplashImage()
        
        return true
    }
    
    func setSplashImage() {
        let splashImage = UIImage(named: "infosys")
        let splashImageView = UIImageView(image: splashImage)
        splashImageView.contentMode = .scaleAspectFit
        splashImageView.frame = UIScreen.main.bounds
        self.window?.rootViewController?.view.addSubview(splashImageView)
        self.window?.rootViewController?.view.bringSubviewToFront(splashImageView)
        
        UIView.animate(withDuration: 1.5, delay: 2.0, options: .curveEaseInOut, animations: {
            splashImageView.alpha = 0.0
            let x: CGFloat = -60.0
            let y: CGFloat = -120.0
            splashImageView.frame = CGRect(x: x, y: y, width: splashImageView.frame.size.width - 2 * x, height: splashImageView.frame.size.height - 2 * y)
        }) { finished in
            if finished {
                splashImageView.removeFromSuperview()
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
    
    func applicationWillTerminate(_ application: UIApplication) {

    }
    
}

