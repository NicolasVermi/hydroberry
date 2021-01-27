//
//  EditProfileView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 15/01/21.
//

import SwiftUI
import DuckMaUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ProfileViewModel(email: "")
    

    
    @State var lastName: String
    @State var firstName: String
    @State var email: String
    @State private var password = ""
    @State private var goOut = false

    
    var body: some View {
        VStack{
            titleBar.padding(.vertical)
            Spacer()
            inputFields
            Spacer()
            passwordStrenght.padding(.vertical, 15)
            Spacer()
        }.padding(16)
        .alert(isPresented: (self.$viewModel.showAlert)) {
            Alert(
              title: Text("Aggiornamento"),
                message: Text(chooseAlert()),
                dismissButton: .default(Text("ok"),action: {if (viewModel.successEmail && viewModel.successPassword){
                                            self.presentationMode.wrappedValue.dismiss()}})
            )
        }
    }
    
    func chooseAlert() -> String{
        var stringa: String = ""

        stringa = "Email: " + viewModel.emailError + "\n Password: " + viewModel.passwordError
            
        
        
        return stringa
    }
    
    var inputFields: some View {
      VStack {
        
        if viewModel.error == .missingFirstName {
            
          VStack(alignment: .leading) {
            firstNameField
              .border(Color.red, width: 1)
            Text("error_mandatory_field")
              .foregroundColor(Color(ColorTheme.current.danger.p100))
          }
        } else {
          firstNameField
        }

        Spacer().frame(height: 22)

        if viewModel.error == .missingLastName {
          VStack(alignment: .leading) {
            lastNameField
              .border(Color.red, width: 1)
            Text("error_mandatory_field")
              .foregroundColor(Color(ColorTheme.current.danger.p100))
          }
        } else {
          lastNameField
        }

        Spacer().frame(height: 28)
        
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
        

      }
    }
    
    
    private var titleBar: some View{
        
        HStack{
            Text("Annulla")
                .padding(17)
                .foregroundColor(.red)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
            }
            Spacer()
            
            Text("Modifica")
                .font(Font.system(size:17, weight: .semibold))
                .multilineTextAlignment(.center)

            Spacer()
            
            
            Button(action: {
                viewModel.updateName(firstName: firstName, lastName: lastName)
                viewModel.updateEmail(email: email)
                viewModel.updatePassword(password: password)
                viewModel.updateFirestore(email: email, firstName: firstName, lastName: lastName)
                    //self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Salva")
                    .padding(17)
                    .font(Font.system(size:17, weight: .semibold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
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
    
    var firstNameField: some View {
      CustomTextField(
        verticalHugging: .defaultHigh,
        horizontalHugging: .defaultLow,
        text: $firstName
      ) {
        let textField = DuckTextField()
        textField.placeholder = "Inserisci nome"
        textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
        textField.cornerRadius = .large
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
      }
    }

    var lastNameField: some View {
      CustomTextField(
        verticalHugging: .defaultHigh,
        horizontalHugging: .defaultLow,
        text: $lastName
      ) {
        let textField = DuckTextField()
        textField.placeholder = "Inserisci cognome"
        textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
        textField.cornerRadius = .large
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
      }
    }
    
    var passwordStrenght: some View {
      PasswordMeterView(password: password)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(lastName: "last", firstName: "first", email: "email@gmail.com")
    }
}
