import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL es inválida"
        case .noData:
            return "No se recibieron datos del servidor"
        case .decodingError:
            return "Error al procesar los datos"
        case .serverError(let statusCode):
            return "Error del servidor: \(statusCode)"
        case .networkError(let error):
            return "Error de conexión: \(error.localizedDescription)"
        }
    }
}
