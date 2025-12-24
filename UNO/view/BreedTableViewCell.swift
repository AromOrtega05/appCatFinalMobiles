import UIKit

class BreedTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    
    static let identifier = "BreedTableViewCell"
    static let nibName = "BreedTableViewCell"
    private var imageTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        breedImageView.image = nil
        imageTask?.cancel()
    }
    
    private func setupUI() {
        
        containerView?.styleAsCard()
       
        breedImageView.styleAsBreedImage()
        
        // Configurar labels
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.numberOfLines = 1
        nameLabel.textColor = .label
        
        originLabel.font = UIFont.systemFont(ofSize: 14)
        originLabel.textColor = .systemGray
        originLabel.numberOfLines = 1
        
        temperamentLabel.font = UIFont.systemFont(ofSize: 14)
        temperamentLabel.textColor = .systemGray2
        temperamentLabel.numberOfLines = 2
        
        // Estilo de la celda
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with breed: Breed) {
        nameLabel.text = breed.name
        originLabel.text = "📍 \(breed.origin ?? "Desconocido")"
        temperamentLabel.text = breed.temperament ?? ""
        breedImageView.loadImageWithIndicator(from: breed.imageURL)
    }
}
