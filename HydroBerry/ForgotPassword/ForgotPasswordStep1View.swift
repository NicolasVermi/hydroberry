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
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Recupera la password")
                .font(Font.system(size:34, weight: .bold))
                .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                .padding(16)
                .padding(.vertical, 40)
            
            inputFields
            Spacer()
            Button(action: {}) {
              UIViewPreview(horizontalHugging: .defaultLow) {
                let button = FullButton()
                button.setTitle("Recupera password", for: .normal)
                button.titleLabel?.font = FontTheme.current.semibold.subhead
                  button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
                button.cornerRadius = .medium
                return button
              }
            }.padding(16)
            Spacer()
        }.padding(16)
    }
    
    var inputFields: some View {
      VStack {
        if viewModel.error == .missingEmail {
          VStack(alignment: .leading) {
            emailView
              .border(Color.red, width: 1)
            Text("Email non corretta")
              .foregroundColor(Color(ColorTheme.current.danger.p100))
          }
        } else {
          emailView
        }

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
        ForgotPasswordStep1View(viewModel: LoginViewModel())
    }
}
