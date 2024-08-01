//
//  String+Extension.swift
//  KhaanaAssist
//
//  Created by Mitul Patel on 21/07/24.
//

import Foundation

extension String {
    
    var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    var isEmail: Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
}

func setDataInString(_ text : AnyObject) -> String {
    var str = ""
    if text is String {
        str = text as! String
    }else if text is Int {
        str = String(text as! Int)
    }else if text is Float {
        str = String(text as! Float)
    }else if text is Double {
        str = String(text as! Double)
    }else if text is NSNumber {
        str = String(describing: text as! NSNumber)
    }
    
    return str
}
