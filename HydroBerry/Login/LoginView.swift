//
//  LoginView.swift
//  Mecha
//
//  Created by Mattia Valzelli on 06/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Combine
import DuckMaUI
import SwiftUI

struct LoginView: View {
  @StateObject var viewModel: LoginViewModel


  @State private var email = ""
  @State private var password = ""

    var head: some View {
      Group {
          HStack{
              Spacer()
              Image("logoDark")
              Spacer()
          }.padding(.top, 30)
        
          
        Spacer()
          .frame(maxHeight: 74)
          Text("Login")
              .font(Font.system(size:20, weight: .bold))
              .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
          .padding([.leading, .trailing], 16)
       
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
    

  var passwordView: some View {
    CustomTextField(
      verticalHugging: .defaultHigh,
      horizontalHugging: .defaultLow,
      text: $password
    ) {
      let textField = DuckTextField()
        textField.placeholder = "Inserisci password"
      textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
      textField.cornerRadius = .large
      textField.autocapitalizationType = .none
      textField.autocorrectionType = .no
      textField.isSecureTextEntry = true
      textField.returnKeyType = .done
      return textField
    }
  }

  var inputFields: some View {
    VStack {
      if viewModel.error == .missingEmail {
        VStack(alignment: .leading) {
          emailView
            
            .border(Color.red, width: 1)
          Text("Mail non corretta")
            .foregroundColor(Color(ColorTheme.current.danger.p100))
        }
      } else {
            emailView
      }

      Spacer().frame(height: 22)

      if viewModel.error == .missingPassword {
        VStack(alignment: .leading) {
          passwordView
            .border(Color.red, width: 1)
          Text("Password non corretta")
            .foregroundColor(Color(ColorTheme.current.danger.p100))
        }
      } else {
        passwordView
      }

      Spacer().frame(height: 22)
    }
  }

  var loginView: some View {
    NavigationView{
    VStack(alignment: .leading) {
      Spacer()
      head

      Spacer()
        .frame(height: 30)

        inputFields
        
        NavigationLink(destination: ForgotPasswordStep1View(viewModel: ForgotPasswordStep1ViewModel())) {
            
              Text("Hai dimenticato la password?")
                .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                .font(.init(FontTheme.current.semibold.caption1))
                .padding([.leading, .trailing], 16)
            
        }.navigationBarHidden(true)
        
      Spacer()

        NavigationLink(destination: HomeView()) {
            Button(action:{login()}){
            UIViewPreview(horizontalHugging: .defaultLow) {
              let button = FullButton()
              button.setTitle("Login", for: .normal)
              button.titleLabel?.font = FontTheme.current.semibold.subhead
                button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
              button.cornerRadius = .medium
              return button
            }
        }
      }
      .padding([.leading, .trailing], 16)

      Spacer()

      HStack {
        Spacer()
        NavigationLink(destination: RegistrationStep1View(viewModel: RegistrationStep1ViewModel())) {
          Text("Registrati")
            .foregroundColor(Color(ColorTheme.current.secondary.dark))
            .font(.init(FontTheme.current.semibold.footnote))
            .multilineTextAlignment(.center)
        }.navigationBarHidden(true)
        Spacer()
      }

      Spacer()
    }.padding(.horizontal,16)
    .navigationBarHidden(true)
  }.navigationBarHidden(true)
}

  var body: some View {
    if viewModel.success{
        HomeView()
    }else{
        
     loginView
        .alert(isPresented: self.$viewModel.showErrorAlert) {
          Alert(
            title: Text(""),
            message: Text(viewModel.errorType),
            dismissButton: .default(Text("ok"))
          )
        }
    }
  }

  private func login() {
    //UIApplication.shared.endEditing()
    viewModel.submit(email: email, password: password)
  }

}

#if DEBUG && canImport(SwiftUI)
  struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
      LoginView(
        viewModel: LoginViewModel()
      )
    }
  }
#endif
