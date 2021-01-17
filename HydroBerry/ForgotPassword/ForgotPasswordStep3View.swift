//
//  ForgotPasswordStep1View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 14/01/21.
//

import SwiftUI
import DuckMaUI

struct ForgotPasswordStep3View: View {
    @State private var password = ""
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
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
                Text("Inserisci la nuova password")
                    .font(Font.system(size:34, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                    .padding(16)
                    .padding(.vertical, 40)
                
                inputFields
                passwordStrenght
                Spacer()
                NavigationLink(destination: LoginView(viewModel: viewModel, showForgotPassword: {}, showRegistration: {})) {
                  UIViewPreview(horizontalHugging: .defaultLow) {
                    let button = FullButton()
                    button.setTitle("Reimposta password", for: .normal)
                    button.titleLabel?.font = FontTheme.current.semibold.subhead
                      button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
                    button.cornerRadius = .medium
                    return button
                  }
                }.padding(16)
                Spacer()
            }.padding(16)
            .navigationBarHidden(true)
        }.navigationBarHidden(true)
            
    }
    
    var inputFields: some View {
        VStack {

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
    var passwordStrenght: some View {
      PasswordMeterView(password: password)
    }
    }
    



struct ForgotPasswordStep3View_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordStep3View(viewModel: LoginViewModel())
    }
}
