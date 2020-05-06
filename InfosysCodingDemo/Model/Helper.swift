



import UIKit
import NVActivityIndicatorView



class Helper: NSObject {
    static let sharedInstance = Helper()
    private var loaderView: NVActivityIndicatorView?
    
    
    func showLoader() {
        if loaderView == nil {
            let frame = CGRect(x: 0, y: 0, width: IS_IPAD() ? 80 : 50, height: IS_IPAD() ? 80 : 50)
            loaderView = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse)
            loaderView?.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: (UIScreen.main.bounds.height / 2.0))
            loaderView?.color = .red
            loaderView?.startAnimating()
            UIApplication.shared.windows.first?.addSubview(loaderView!)
        }
    }

    func hideLoader() {
        if loaderView != nil {
            loaderView?.removeFromSuperview()
            loaderView = nil
        }
    }

    func IS_IPAD() -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return false
        case .pad:
            return true
        case .unspecified: 
            return false
        default:
            return false
        }
    }
    
}
