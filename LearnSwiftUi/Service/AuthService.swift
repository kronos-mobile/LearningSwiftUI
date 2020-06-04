import Foundation
import Combine

enum SignUpError: Error {
    case emailExists
    case invalidData
    case invalidJSON
    case error(error: String)
}

enum AuthResult<T> {
    case success(value: T)
    case failure(message: String)
}

class AuthService {
    lazy var httpService = AuthHttpService()
    static let shared: AuthService = AuthService()
    private init() {}
}

extension AuthService: AuthApi {
//    func signUp(username: String,
//        email: String,
//        password: String,
//        success: @escaping (String, String, Int) -> Void,
//        failure: @escaping (String) -> Void)
    func signUp(username: String,
                email: String,
                password: String) -> Future<(statusCode: Int, data: Data), Error> {
        
        return Future<(statusCode: Int, data: Data), Error> {[httpService] promise in
            do {
                    try AuthHttpRouter
                            .signUp(AuthModel(name: username, email: email, password: password))
                        .request(usingHttpService: httpService)
                            .responseJSON { (response) in
                                print("Sign Up status code: \(String(describing: response.response?.statusCode))")
                                print("Request Body: \(String(data: (response.request?.httpBody)!, encoding: .utf8 ) as String?)")
                                
                                guard let statusCode = response.response?.statusCode, let data = response.data, statusCode == 200 else {
                                    promise(.failure(SignUpError.invalidData))
                                    return
                                }
                                
                                promise(.success((statusCode: statusCode, data: data)))
                            }
                } catch {
                    print("Signing in failed = \(error)")
                    promise(.failure(SignUpError.invalidData))
                }
        }
    }
    
    func checkEmail(email: String) -> Future<Bool, Never> {
        return Future<Bool, Never> {[httpService] promise in
            do {
                try AuthHttpRouter
                    .validateEmail(email: email)
                    .request(usingHttpService: httpService)
                    .responseJSON { response in
                        print("response: \(response)")
                        guard response.response?.statusCode == 200 else {
                            promise(.success(false))
                            return
                        }
                        
                        promise(.success(true))
                    }
            } catch {
                promise(.success(false))
            }
        }
    }
    
    
}
