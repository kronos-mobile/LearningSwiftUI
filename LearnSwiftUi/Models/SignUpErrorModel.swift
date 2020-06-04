import Foundation

// MARK: - AuthError
struct SignUpErrorModel: Codable {
    let validationErrors: ValidationErrors
    
    enum CodingKeys: String, CodingKey {
        case validationErrors = "validation_errors"
    }
    
}

// MARK: - ValidationErrors
struct ValidationErrors: Codable {
    let name, email, password: [String]?
}
