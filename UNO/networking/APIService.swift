import Foundation

// MARK: - API Service Protocol
protocol APIServiceProtocol {
    func fetchBreeds(completion: @escaping (Result<[Breed], APIError>) -> Void)
}

// MARK: - API Service
class APIService: APIServiceProtocol {
    
    static let shared = APIService()
    
    private let baseURL = "https://api.thecatapi.com/v1"
    private let apiKey = "live_hB1dxeycAGzaYvMkCe0OQ0lSsssq9yVjYiFCrw6GvLOFbxN82EvK8vJJcma8i2Ho" // Reemplaza con tu API key
    
    private init() {}
    
    func fetchBreeds(completion: @escaping (Result<[Breed], APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/breeds") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let breeds = try JSONDecoder().decode([Breed].self, from: data)
                completion(.success(breeds))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

