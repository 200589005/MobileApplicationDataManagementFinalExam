

import UIKit

extension UIViewController {
    // Source : EZSwiftExtensions
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }

    func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }
    
    func setupDefaultNavigation() {
        let appearance = UINavigationBarAppearance()
          appearance.configureWithDefaultBackground()
          appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
          appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.backButtonDisplayMode = .generic
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}


extension UIViewController {
    
    enum Storyboard: String {
        case main = "Main"
    }
    
    class func instantiateViewController<T: UIViewController>(identifier : Storyboard) -> T {
        let storyboard =  UIStoryboard(name: identifier.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.self) ")
        }
        
        return viewController
    }
   
}


extension UIViewController {
    func showAlertWithOkAndCancelHandler(string: String,strOk:String,strCancel : String,handler: @escaping (_ isOkBtnPressed : Bool)->Void)
    {
        
        
        let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
        
        let alertOkayAction = UIAlertAction(title: strOk, style: .default) { (alert) in
            handler(true)
        }
        let alertCancelAction = UIAlertAction(title: strCancel, style: .default) { (alert) in
            handler(false)
        }
        alert.addAction(alertCancelAction)
        alert.addAction(alertOkayAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showAlertwithOkHandler(string:String,strBtnTitle:String,handler: @escaping ()->Void) -> Void {
        
        let alert : UIAlertController = UIAlertController(title: "", message: string, preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: strBtnTitle, style: .default) { (alert) in
            handler()
        }
        alert.addAction(alertCancelAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    func showAlert(string:String) -> Void {
        
        let alert : UIAlertController = UIAlertController(title: "", message: string, preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: "Okay", style: .default) { (alert) in
            
        }
        alert.addAction(alertCancelAction)
        self.present(alert, animated: true, completion: nil)

    }
    
    @discardableResult public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    
}
