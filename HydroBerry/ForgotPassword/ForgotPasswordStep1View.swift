//
//  ForgotPasswordStep1View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 14/01/21.
//

import SwiftUI
import DuckMaUI

struct ForgotPasswordStep1View: View {
    @State private var email = ""
    @State private var changeView = false
    @ObservedObject var viewModel: ForgotPasswordStep1ViewModel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        if viewModel.success{
            LoginView(viewModel: LoginViewModel(), showForgotPassword: {true}, showRegistration: {})
        }else{
            NavigationView{
            VStack(alignment:.leading){
                HStack{
                    Image(systemName: "chevron.left").foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                        .contentShape(Rectangle())
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()

                      }
                
                    Spacer()
                }
                Text("Recupera la password")
                    .font(Font.system(size:34, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                    .padding(16)
                    .padding(.vertical, 40)
                
                inputFields
                Spacer()

                Button(action:
                        {viewModel.passwordRecovery(email: email);

                        }){
                    
                  UIViewPreview(horizontalHugging: .defaultLow) {
                    let button = FullButton()
                    button.setTitle("Recupera password", for: .normal)
                    button.titleLabel?.font = FontTheme.current.semibold.subhead
                      button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
                    button.cornerRadius = .medium
                    return button
                  
                    }
                        .padding(16)
                    
                }
                
                Spacer()
            }.padding(16)
            .navigationBarHidden(true)
            }.alert(isPresented: (self.$viewModel.showAlert)) {
                Alert(
                  title: Text(""),
                  message: Text(viewModel.errorType),
                  dismissButton: .default(Text("ok"))
                )
              }
            .navigationBarHidden(true)
        }
    }
    private func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            changeView = true
        }
      }
    var inputFields: some View {
      VStack {
          emailView
      }
    }
    
    var emailView: some View {
      CustomTextField(verticalHugging: .defaultHigh, horizontalHugging: .defaultLow, text: $email) {
        let textField = DuckTextField()
        textField.placeholder = "Inserisci mail"
        textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
        textField.cornerRadius = .large
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        return textField
      }
    }
}

struct ForgotPasswordStep1View_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordStep1View(viewModel: ForgotPasswordStep1ViewModel())
    }
}
