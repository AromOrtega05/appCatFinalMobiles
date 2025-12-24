//
//  UIActivityIndicatorView.swift
//  UNO
//
//  Created by DAMII on 19/12/25.
//

import UIKit

extension UIActivityIndicatorView {
    
    func setColor(_ color: UIColor) {
        self.color = color
    }
    
    func setStyle(_ style: UIActivityIndicatorView.Style) {
        self.style = style
    }
    
    func startLoading() {
        self.startAnimating()
        self.isHidden = false
    }
    
    func stopLoading() {
        self.stopAnimating()
        self.isHidden = true
    }
}
