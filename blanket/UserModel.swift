import Foundation

struct User: Codable {
    let name: String
    let birthdate: String
    let gender: String
    let city: String
    let email: String
    let password: String
}

struct LoginUser: Codable {
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let access_token: String
    let token_type: String
}
