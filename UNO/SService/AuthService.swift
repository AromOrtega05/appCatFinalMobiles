//
//  AuthService.swift
//  UNO
//
//  Created by Suite on 21/12/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    // --- Iniciar Sesión ---
    func login(email: String, pass: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    // --- Registrarse (Guarda Auth + Firestore) ---
    func register(email: String, pass: String, name: String, phone: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        // 1. Crear usuario en Auth
        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            // 2. Guardar datos extra en Firestore
            self?.saveUserToFirestore(uid: uid, email: email, name: name, phone: phone, completion: completion)
        }
    }
    
    // --- Guardar en Firestore (Privada) ---
    private func saveUserToFirestore(uid: String, email: String, name: String, phone: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        
        let userData: [String: Any] = [
            "uid": uid,
            "email": email,
            "name": name,
            "phone": phone,
            "createdAt": Timestamp(date: Date())
        ]
        
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
    
    // --- Traer datos del usuario (Para el Perfil) ---
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = snapshot?.data() {
                completion(.success(data))
            } else {
                let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No se encontraron datos del usuario"])
                completion(.failure(error))
            }
        }
    }
    
    // --- NUEVO: Recuperar Contraseña ---
    func resetPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    // --- Cerrar Sesión ---
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    // --- Obtener Email del usuario actual ---
    func getUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
}
