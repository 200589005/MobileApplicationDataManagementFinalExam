//
//  UIButton+Extension.swift
//  KhaanaAssist
//
//  Created by Mitul Patel on 30/07/24.
//

import Foundation
import UIKit

extension UIButton {
    
    func setTitleForAllState(title: String?) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .selected)
        self.setTitle(title, for: .highlighted)
    }
    
}
