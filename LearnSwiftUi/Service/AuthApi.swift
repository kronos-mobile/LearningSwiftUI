import Foundation
import Combine

//protocol AuthApi {
//    func checkEmail(email: String) -> Future<Bool, Never>
//    func signUp(username: String, email: String, password: String) -> Future<(statusCode: Int, data: Data), Error>
//}

protocol AuthApi {
    func signUp(username: String,
                email: String,
                password: String
                ) -> Future<(statusCode: Int, data: Data), Error>
    func checkEmail(email: String) -> Future<Bool, Never>
}
