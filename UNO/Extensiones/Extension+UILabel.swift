import UIKit

extension UILabel {
    
    func setText(_ text: String) {
        self.text = text
    }
    
    func setColor(_ color: UIColor) {
        self.textColor = color
    }
    
    func setFontSize(_ size: Double) {
        self.font = UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    func setBoldFontSize(_ size: Double) {
        self.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
    
    func setAlignment(_ alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
    
    func setNumberOfLines(_ lines: Int) {
        self.numberOfLines = lines
    }
    
    func setLinesFree() {
        self.numberOfLines = 0
    }
}
