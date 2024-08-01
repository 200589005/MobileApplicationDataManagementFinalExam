//
//  AppThemeButton.swift


import Foundation
import UIKit

class AppThemeButton : UIButton {
    
    // MARK:- AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateProperty()
    }
    
    // MARK:- Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.updateProperty()
    }
    
    // MARK:- Set Property
    func updateProperty() {
        self.backgroundColor = UIColor.black
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.setTitleColor(.white, for: .highlighted)
        self.viewCornerRadius = 5;
        self.titleLabel?.font = UIFont.font_Poppins_Medium(size: 16)
    }
    
}

