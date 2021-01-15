//
//  RegistrationStep1View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 13/01/21.
//

import SwiftUI
import DuckMaUI

struct RegistrationStep1View: View {
    @State private var email = ""
    @State private var password = ""
    @State private var acceptedPrivacyPolicy = false
    @State private var acceptedTerms = false
    @State private var showStep2 = false
    
    @ObservedObject var viewModel: RegistrationStep1ViewModel
    
    
    
    var body: some View {
        if showStep2{
            RegistrationStep2View(viewModel: RegistrationStep2ViewModel(
                email: email,
                password: password
              ))
            
        }
        else{
            registration

        }
    }
    
    
    
    var inputFields: some View {
      VStack {
        if viewModel.error == .missingEmail {
          Group {
            emailView
              .border(Color.red, width: 1)
            HStack {
              Text("Error")
                .foregroundColor(Color(ColorTheme.current.danger.p100))
              Spacer()
            }
          }
        } else if viewModel.error == .emailNotAvailable {
          emailView
            .border(Color.red, width: 1)
          HStack {
            Text("Email già registrata")
              .foregroundColor(Color(ColorTheme.current.danger.p100))
            Spacer()
          }
        } else {
          emailView
        }

        Spacer().frame(height: 22)

        if viewModel.error == .password {
          VStack(alignment: .leading) {
            passwordView
              .border(Color.red, width: 1)
            Text("Password debole")
              .foregroundColor(Color(ColorTheme.current.danger.p100))
              .lineLimit(nil)
              .fixedSize(horizontal: false, vertical: false)
          }
        } else {
          passwordView
        }

        Spacer().frame(height: 28)
      }
    }
    
    
    
    var passwordStrenght: some View {
      PasswordMeterView(password: password)
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
    
    
    var head: some View {
      Group {
          HStack{
              Spacer()
              Image("logoDark")
              Spacer()
          }.padding(.top, 30)
        
          
        Spacer()
          .frame(maxHeight: 74)
          Text("Registrazione")
              .font(Font.system(size:20, weight: .bold))
              .foregroundColor(Color(red: 1, green: 163/255, blue: 108/255))
              
          .padding([.leading, .trailing], 16)
        Spacer()
          .frame(maxHeight: 30)
        Text("step1")
          .font(Font.system(size:12, weight: .regular))
          .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
          .padding([.leading, .trailing], 16)
      }
    }
    //mariorossi@gmail.com
    
    
    var registration: some View {
      VStack(alignment: .leading) {
        head
        Spacer()
        Group {
          inputFields
          passwordStrenght
        }
        .padding([.leading, .trailing], 16)
        

        Spacer()
        
            Button(action: { showStep2 = true }) {
              UIViewPreview(horizontalHugging: .defaultLow) {
                let button = FullButton()
                button.setTitle("Avanti", for: .normal)
                button.titleLabel?.font = FontTheme.current.semibold.subhead
                button.cornerRadius = .medium
                button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
                return button
              }.padding(.vertical, 5)
              .background(Color(red: 21/255, green: 132/255, blue: 103/255))
            }.cornerRadius(5)
            .padding([.leading, .trailing], 16)
        
        

        Spacer().frame(height: 24)

        HStack {
          Spacer()
          Button(action: { self.viewModel.showLogin() }) {
            Text("Login")
              .foregroundColor(Color(ColorTheme.current.secondary.dark))
              .fixedSize(horizontal: false, vertical: true)
              .font(.init(FontTheme.current.semibold.footnote))
              .multilineTextAlignment(.center)
          }
          Spacer()
        }

        Spacer()
      }
      //.horizantalPaddingMultiplying([.leading, .trailing], 16)
      //.keyboardAdaptive()
      //.dismissOnTap()
      //.embedInScrollView()
    }
}

struct RegistrationStep1View_Previews: PreviewProvider {
    static var previews: some View {
      RegistrationStep1View(
        viewModel: .init(
          showPrivacy: {},
          showTerms: {},
          nextStep: { _, _ in },
          showLogin: {}
        )
      )
    }
}
