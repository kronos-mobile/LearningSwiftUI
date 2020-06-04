import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    private var cancellableBag = Set<AnyCancellable>()
    
    @Published var username: String = "Test"
    var usernameError: String = "Required"
    @Published var email: String = "test@mail.com"
    var emailError: String = "Required"
    @Published var password: String = "123"
    var passwordError: String = "Required"
    @Published var confirmPassword: String = "123"
    var confirmPasswordError: String = "Required"
    
    private var usernameValidPublisher: AnyPublisher<Bool, Never> {
        return $username
//            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    init() {
        usernameValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0 ? "": "Username is missing" }
            .assign(to: \.usernameError, on: self)
            .store(in: &cancellableBag)
    }
}
