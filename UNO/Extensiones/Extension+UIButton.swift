import UIKit

extension UIButton {
    
    func setTitleText(_ text: String) {
        self.setTitle(text, for: .normal)
    }
    
    func setTitleColor(_ color: UIColor) {
        self.setTitleColor(color, for: .normal)
    }
    
    
    func setSystemImage(_ systemName: String) {
        self.setImage(UIImage(systemName: systemName), for: .normal)
    }
    
    func setTintColor(_ color: UIColor) {
        self.tintColor = color
    }
    
    func setBoldFontSize(_ size: Double) {
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
    
    func setFontSize(_ size: Double) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    func setShadow(color: UIColor = .black, opacity: Float = 0.1, radius: Double = 4) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = CGFloat(radius)
        self.layer.masksToBounds = false
    }
}
