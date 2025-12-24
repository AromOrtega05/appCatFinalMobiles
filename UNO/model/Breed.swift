import Foundation

// MARK: - Breed Model
struct Breed: Codable, Identifiable {
    let id: String
    let name: String
    let temperament: String?
    let origin: String?
    let description: String?
    let lifeSpan: String?
    let weight: Weight?
    let image: BreedImage?
    
    enum CodingKeys: String, CodingKey {
        case id, name, temperament, origin, description, weight, image
        case lifeSpan = "life_span"
    }
}

// MARK: - Weight
struct Weight: Codable {
    let imperial: String?
    let metric: String?
}

// MARK: - Breed Image
struct BreedImage: Codable {
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
}

// MARK: - Extensions
extension Breed {
    var imageURL: URL? {
        guard let urlString = image?.url else { return nil }
        return URL(string: urlString)
    }
    
    var displayWeight: String {
        weight?.metric ?? "Desconocido"
    }
    
    var displayLifeSpan: String {
        lifeSpan ?? "Desconocido"
    }
}
