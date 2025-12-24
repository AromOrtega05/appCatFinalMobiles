//
//  CatService.swift
//  UNO
//
//  Created by Suite on 19/12/25.
//

import Foundation

class CatService {
    
    static let shared = CatService()
    
    private let baseURL = "https://api.thecatapi.com/v1"
    private let apiKey = ""
    
    private init() {}
    
    func fetchBreeds(completion: @escaping (Result<[Breed], Error>) -> Void) {
        let url = "\(baseURL)/breeds"
        
        // Headers requeridos por la API de gatos
        let headers = ["x-api-key": apiKey]
        
        // Llamada usando tu APICaller.shared.request
        // Como es un GET, el body es nil (le indicamos String? para cumplir con el genérico B)
        APICaller.shared.request(
            url: url,
            method: "GET",
            headers: headers,
            body: nil as String?,
            completion: completion
        )
    }
}
