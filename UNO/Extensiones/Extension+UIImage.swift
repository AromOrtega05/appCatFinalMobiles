import UIKit

extension UIImageView {
    
    // MARK: - Visual Setters
    func setSystemImage(_ systemName: String) {
        self.image = UIImage(systemName: systemName)
    }
    
    func setTintColor(_ color: UIColor) {
        self.tintColor = color
    }
    
    func setContentMode(_ mode: UIView.ContentMode) {
        self.contentMode = mode
    }
    
    // MARK: - Styling
    func styleAsBreedImage() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: - Networking
    func loadImage(from url: URL?, placeholder: UIImage? = UIImage(systemName: "photo")) {
        self.image = placeholder
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.image = placeholder
                }
            }
        }.resume()
    }
    
    func loadImageWithIndicator(from url: URL?) {
        self.image = UIImage(systemName: "photo")
        guard let url = url else { return }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        activityIndicator.color = .systemOrange
        activityIndicator.startAnimating()
        activityIndicator.tag = 999
        addSubview(activityIndicator)
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let indicator = self?.viewWithTag(999) as? UIActivityIndicatorView {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                }
                
                if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.image = UIImage(systemName: "photo")
                }
            }
        }.resume()
    }
}
