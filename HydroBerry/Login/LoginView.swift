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
  @ObservedObject var viewModel: LoginViewModel
  let showForgotPassword: () -> Void
  let showRegistration: () -> Void

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
    VStack(alignment: .leading) {
      Spacer()
      head

      Spacer()
        .frame(height: 30)

        inputFields

      Button(action: { self.showForgotPassword() }) {
        Text("Hai dimenticato la password?")
          .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
          .font(.init(FontTheme.current.semibold.caption1))
          .padding([.leading, .trailing], 16)
      }

      Spacer()

      Button(action: { self.login() }) {
        UIViewPreview(horizontalHugging: .defaultLow) {
          let button = FullButton()
          button.setTitle("Login", for: .normal)
          button.titleLabel?.font = FontTheme.current.semibold.subhead
            button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
          button.cornerRadius = .medium
          return button
        }
      }
      .padding([.leading, .trailing], 16)

      Spacer()

      HStack {
        Spacer()
        Button(action: { self.showRegistration() }) {
          Text("Registrati")
            .foregroundColor(Color(ColorTheme.current.secondary.dark))
            .font(.init(FontTheme.current.semibold.footnote))
            .multilineTextAlignment(.center)
        }
        Spacer()
      }

      Spacer()
    }.padding(.horizontal,16)
  }

  var body: some View {
    //LoadingView(isShowing: $viewModel.isLoading) {
      self.loginView
        .alert(isPresented: self.$viewModel.showErrorAlert) {
          Alert(
            title: Text(""),
            message: Text("error_generic"),
            dismissButton: .default(Text("ok"))
          )
        }
        //.horizantalPaddingMultiplying([.leading, .trailing], 16)
        //.keyboardAdaptive()
        //.dismissOnTap()
    //}
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
        viewModel: LoginViewModel(
            //api: MockLoginService(),
            //onLogin: {}
        ),
        showForgotPassword: {},
        showRegistration: {}
      )//.previewAsScreen(colorSchemes: [.light])
    }
  }
#endif
