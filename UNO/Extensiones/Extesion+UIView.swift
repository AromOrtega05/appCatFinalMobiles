import UIKit

extension UIView {
    
    // MARK: - Setters Básicos
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setCornerRadius(_ radius: Double) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func setBorder(width: Double, color: UIColor) {
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color.cgColor
    }
    
    func setShadow(color: UIColor = .black, opacity: Float = 0.1, radius: Double = 4, offset: CGSize = CGSize(width: 0, height: 2)) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = CGFloat(radius)
        self.layer.masksToBounds = false
    }
    
    // MARK: - Styling Específico
    func styleAsCard() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 16
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.08
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
    }
    
    // MARK: - Animaciones
    /// Anima nuestro color del borde para indicar foco (naranja) o reposo (gris)
    func animateBorder(active: Bool) {
        // Colores configurados para nuestro Login
        let color: UIColor = active ? .systemOrange : .systemGray4
        let width: CGFloat = active ? 1.5 : 1.0
        
        UIView.animate(withDuration: 0.3) {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
        }
    }
}
