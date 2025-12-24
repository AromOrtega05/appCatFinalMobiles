//
//  APICaller.swift
//  UNO
//
//  Created by Suite on 19/12/25.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    private init() {}
    
    func request<R: Codable, B: Codable>(
        url: String,
        method: String = "GET",
        headers: [String: String] = [:],
        body: B? = nil,
        completion: @escaping (Result<R, Error>) -> Void
    ) {
        guard let endpoint = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = method
        
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let http = response as? HTTPURLResponse,
                  (200..<300).contains(http.statusCode) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data else {
                completion(.failure(URLError(.cannotDecodeRawData)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(R.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
