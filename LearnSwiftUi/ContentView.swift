import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ColorCodes.primary.color()
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Green Grocery")
                    .font(Font.custom("Noteworthy-Bold", size: 40.0))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 20.0)
                
                AuthTextField(title: "Username", textValue: $viewModel.username, errorValue: viewModel.usernameError)
                AuthTextField(title: "Email", textValue: $viewModel.email, errorValue: viewModel.emailError, keyboardType: .emailAddress)
                AuthTextField(title: "Password", textValue: $viewModel.password, errorValue: viewModel.passwordError, isSecured: true)
                AuthTextField(title: "Confirm Password", textValue: $viewModel.confirmPassword, errorValue: viewModel.confirmPasswordError, isSecured: true)
                
                Button(action: viewModel.signUp) {
                    Text("Sign Up")
                }
                .disabled(!viewModel.enableSignUp)
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.white)
                .padding()
                .background(viewModel.enableSignUp ? Color.black : Color.gray)
                .cornerRadius(.infinity)
                .padding(.top, 20.0)
                
                Text(viewModel.statusViewModel.title)
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(viewModel.statusViewModel.color.color())
                    .padding(.top)
                
            }.padding(60.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel(authApi: AuthService.shared, authServiceParser: AuthServiceParser.shared)
        return ContentView(viewModel: viewModel)
    }
}

extension ColorCodes {
    func color() -> Color {
        switch self {
        case .primary:
            return Color(red: 79/255, green: 139/255, blue: 43/255)
        case .success:
            return Color(red: 0, green: 0, blue: 0)
        case .failure:
            return Color(red: 219/255, green: 12/255, blue: 12/255)
        case .background:
            return Color(red: 239.0/255.0, green: 243/255, blue: 244/255, opacity: 1.0)
        }
    }
}

struct AuthTextField: View {
    var title: String
    @Binding var textValue: String
    var errorValue: String
    var isSecured: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack {
            if isSecured {
                SecureField(title, text: $textValue)
                .padding()
                .background(ColorCodes.background.color())
                .cornerRadius(5)
                .keyboardType(keyboardType)
            } else {
                TextField(title, text: $textValue)
                .padding()
                .background(ColorCodes.background.color())
                .cornerRadius(5)
                .keyboardType(keyboardType)
            }
            
            Text(errorValue)
                .fontWeight(.light)
                .foregroundColor(ColorCodes.failure.color())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
    }
}
