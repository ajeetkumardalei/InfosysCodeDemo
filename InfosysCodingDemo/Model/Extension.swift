





import Foundation
import UIKit
import AlamofireImage



extension UIView {
    func setRoundCornder(_ borderWid:CGFloat = 1.0, _ borderClr:UIColor = .lightGray) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.layer.borderColor = borderClr.cgColor
        self.layer.borderWidth = borderWid
    }
}

extension UIImageView {
    func setImageFromAlmofireURL(strImgURL:String, isShowIndicator:Bool = false, placeholderimg:UIImage? = Placeholder.noImage, completionHandler:(_ success:Bool) -> () ) {
        
        let activityIndicator = UIActivityIndicatorView()
        if isShowIndicator {
            self.layoutIfNeeded()
            activityIndicator.color = .purple
            activityIndicator.hidesWhenStopped = true
            self.addSubview(activityIndicator)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                activityIndicator.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
                activityIndicator.startAnimating()
            }
        }
        
        guard let url = URL(string: strImgURL) else {return}
        
        self.af.setImage(withURL: url, cacheKey: nil, placeholderImage: Placeholder.noImage, serializer: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: ImageTransition.crossDissolve(0), runImageTransitionIfCached: true) { (imgData) in
        if (isShowIndicator) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                activityIndicator.stopAnimating()
            })
        }
        }
    }
}

extension UIViewController {
    func showAlertSimple(title:String? = "Alert!", msg:String? = "This is alert", isAutoDismiss:Bool = true){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed OK");
        }

        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        
        if isAutoDismiss == true {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showAlertWithAction(title:String? = "Alert!", msg:String? = "This is alert", okbtn:String? = "OK", cancelbtn:String? = "Cancel"){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed OK");
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

