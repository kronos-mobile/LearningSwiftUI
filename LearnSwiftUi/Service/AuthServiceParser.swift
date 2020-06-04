import Foundation
import Combine

protocol AuthServiceParseable {
    func parseSignUpResponse(statusCode: Int, data: Data) ->
        AnyPublisher<AuthResult<TokenResponseModel>, Error>
}

class AuthServiceParser: AuthServiceParseable {
    static let shared: AuthServiceParser = AuthServiceParser()
    
    private init() {}
    
    func parseSignUpResponse(statusCode: Int, data: Data) -> AnyPublisher<AuthResult<TokenResponseModel>, Error> {
        
        return Just((statusCode: statusCode, data: data))
            .tryMap { args -> AuthResult<TokenResponseModel> in
                guard args.statusCode == 200 else {
                    do {
                        let authError = try JSONDecoder().decode(SignUpErrorModel.self, from: args.data)
                        if let nameError = authError.validationErrors.name?.first {
                            return .failure(message: nameError)
                        }
                        
                        if let emailError = authError.validationErrors.email?.first {
                            return .failure(message: emailError)
                        }
                        
                        if let passwordError = authError.validationErrors.password?.first {
                            return .failure(message: passwordError)
                        }
                    } catch {
                        print("signing in failed = \(error)")
                    }
                    
                    return .failure(message: "Signing in failed")
                }
                
                guard let tokenResponseModel = try? JSONDecoder().decode(TokenResponseModel.self, from: args.data) else {
                    throw SignUpError.invalidJSON
                }
                
                return .success(value: tokenResponseModel)
        }.eraseToAnyPublisher()
    }
}
