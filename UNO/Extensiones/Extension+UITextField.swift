//
//  Extension+UITextField.swift
//  UNO
//
//  Created by Suite on 20/12/25.
//

import UIKit

extension UITextField {
    
    func setPlaceholderText(_ text: String) {
        self.placeholder = text
    }
    
    func setIsSecure(_ isSecure: Bool) {
        self.isSecureTextEntry = isSecure
    }
    
    func setReturnKey(_ type: UIReturnKeyType) {
        self.returnKeyType = type
    }
    
    func setNoAutoCorrection() {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
}
