import Foundation
import Combine

class StatusViewModel: ObservableObject {
    var title: String
    var color: ColorCodes
    
    init(title: String, color: ColorCodes) {
        self.title = title
        self.color = color
    }
}

class SignUpViewModel: ObservableObject {
    private let authApi: AuthApi
    private let authServiceParser: AuthServiceParseable
    private var cancellableBag = Set<AnyCancellable>()
    
    @Published var username: String = ""
    @Published var usernameError: String = "Required"
    @Published var email: String = ""
    @Published var emailError: String = "Required"
    @Published var password: String = ""
    @Published var passwordError: String = "Required"
    @Published var confirmPassword: String = ""
    @Published var confirmPasswordError: String = "Required"
    @Published var enableSignUp: Bool = false
    @Published var statusViewModel: StatusViewModel = StatusViewModel(title: "", color: .success)
    
    private var usernameValidPublisher: AnyPublisher<Bool, Never> {
        return $username
//            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var emailRequiredPublisher: AnyPublisher<(email: String, isValid: Bool), Never> {
            return $email
                .map{ (email: $0, isValid: !$0.isEmpty) }
                .eraseToAnyPublisher()
    }
    
    private var emailValidPublisher: AnyPublisher<(email: String, isValid: Bool), Never> {
        return emailRequiredPublisher
            .filter { $0.isValid }
            .map { (email: $0.email, isValid: $0.email.isValidEmail()) }
            .eraseToAnyPublisher()
    }
    
    private var emailServerValidPublisher: AnyPublisher<Bool, Never> {
        return emailValidPublisher
            .filter { $0.isValid }
            .map { $0.email }
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap {[authApi] in authApi.checkEmail(email: $0) }
            .eraseToAnyPublisher()
    }
    
    private var passwordRequiredPublisher: AnyPublisher<(password: String, isValid: Bool), Never> {
            return $password
                .map{ (passowrd: $0, isValid: !$0.isEmpty) }
                .eraseToAnyPublisher()
    }
    
    private var passwordValidPublisher: AnyPublisher<Bool, Never> {
        return passwordRequiredPublisher
            .filter { $0.isValid }
            .map { $0.password.isValidPassword() }
            .eraseToAnyPublisher()
    }
    
    private var confirmPasswordRequiredPublisher: AnyPublisher<(password: String, isValid: Bool), Never> {
            return $password
                .map{ (passowrd: $0, isValid: !$0.isEmpty) }
                .eraseToAnyPublisher()
    }
    
    private var passwordEqualPublisher: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($password, $confirmPassword)
            .filter { !$0.0.isEmpty && !$0.1.isEmpty }
            .map { password, confirm in
                return password == confirm
            }
            .eraseToAnyPublisher()
    }
    
    
    
    init(authApi: AuthApi, authServiceParser: AuthServiceParseable) {
        self.authApi = authApi
        self.authServiceParser = authServiceParser
        
        usernameValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0 ? "": "Username is missing" }
            .assign(to: \.usernameError, on: self)
            .store(in: &cancellableBag)
        
        emailRequiredPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0.isValid ? "": "Email is missing" }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellableBag)
        
        emailValidPublisher
            .receive(on: RunLoop.main)
            .map { $0.isValid ? "": "Email is not valid" }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellableBag)
        
        emailServerValidPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? "": "Email is already used" }
            .assign(to: \.emailError, on: self)
            .store(in: &cancellableBag)
        
        passwordRequiredPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0.isValid ? "": "Password is missing" }
            .assign(to: \.passwordError, on: self)
            .store(in: &cancellableBag)
        
        passwordValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0 ? "": "Password must be 8 characters with 1 alphabet and 1 number" }
            .assign(to: \.passwordError, on: self)
            .store(in: &cancellableBag)
        
        confirmPasswordRequiredPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { $0.isValid ? "": "Confirm Password is missing" }
                .assign(to: \.confirmPasswordError, on: self)
            .store(in: &cancellableBag)
        
        passwordEqualPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? "": "Passwords does not match" }
                .assign(to: \.confirmPasswordError, on: self)
            .store(in: &cancellableBag)
        
        Publishers.CombineLatest4(usernameValidPublisher, emailServerValidPublisher, passwordValidPublisher, passwordEqualPublisher)
            .map { username, email, password, confirm in
                return username && email && password && confirm
            }
            .receive(on: RunLoop.main)
            .assign(to: \.enableSignUp, on: self)
            .store(in: &cancellableBag)
    }
    
    
    deinit {
        cancellableBag.removeAll()
    }
}

extension SignUpViewModel {
    func signUp() -> Void {
        authApi.signUp(username: username, email: email, password: password)
            .flatMap {[authServiceParser] in
                authServiceParser.parseSignUpResponse(statusCode: $0.statusCode, data: $0.data)
        }
        .map { result in
            switch result {
            case .success:
                return StatusViewModel(title: "Sign Up is successful", color: ColorCodes.success)
            case .failure:
                return StatusViewModel(title: "Sign Up failed", color: ColorCodes.failure)
            }
        }
        .receive(on: RunLoop.main)
        .replaceError(with: StatusViewModel(title: "Sign Up failed", color: ColorCodes.failure))
        .handleEvents(receiveOutput: {[weak self] _ in
            self?.username = ""
            self?.email = ""
            self?.password = ""
            self?.confirmPassword = ""
        })
        .assign(to: \.statusViewModel, on: self)
        .store(in: &cancellableBag)
    }
}

extension String {
    func isValidEmail() -> Bool {
        // https://regexr.com/
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword(pattern: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$") -> Bool {
        let passwordRegex = pattern
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
