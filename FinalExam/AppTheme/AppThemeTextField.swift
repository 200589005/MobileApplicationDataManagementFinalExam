//
//  AppThemeTextField.swift
//  Dhanify
//
//  Created by Mitul Patel on 08/06/24.
//

import UIKit

class AppThemeTextField: UITextField {
    
    @IBInspectable var placeholderColor: UIColor {
            get {
                return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
            }
            set {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
            }
        }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        self.updateProperties()
    }
    
    func updateProperties() {
        self.viewCornerRadius = 5;
        self.textColor = .white;
        self.viewBorderWidth = 1;
        self.viewBorderColor = .white;
        
    }
    
}
