//
//  RegistrationStep2View.swift
//  Mecha
//
//  Created by Mattia Valzelli on 08/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import DuckMaUI
import SwiftUI

struct RegistrationStep2View: View {
  @State private var firstName = ""
  @State private var lastName = ""

  @ObservedObject var viewModel: RegistrationStep2ViewModel

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
      Text("step2")
        .font(Font.system(size:12, weight: .regular))
        .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
        .padding([.leading, .trailing], 16)
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
    }
  }

  var registration: some View {
    VStack(alignment: .leading) {
      
      head

      Spacer()
        .frame(height: 30)

      inputFields

      Spacer()

      Button(action: {}) {
        UIViewPreview(horizontalHugging: .defaultLow) {
          let button = FullButton()
          button.setTitle("Registrati", for: .normal)
          button.titleLabel?.font = FontTheme.current.semibold.subhead
          button.cornerRadius = .medium
            button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
          return button
        }
      }
      .padding([.leading, .trailing], 16)



      Spacer()
    }

  }

  var body: some View {
    //LoadingView(isShowing: $viewModel.isLoading){
      self.registration
        .alert(isPresented: self.$viewModel.showErrorAlert) {
          Alert(
            title: Text(""),
            message: Text("error_generic"),
            dismissButton: .default(Text("ok"))
          )
        }.padding()
    //}
  }
/*
  private func signup() {
    UIApplication.shared.endEditing()
    viewModel.signup(firstName: firstName, lastName: lastName)
  }*/
}

#if DEBUGF
  struct RegistrationStep2View_Previews: PreviewProvider {
    static var previews: some View {
      RegistrationStep2View(viewModel: .mock)
        //.previewAsScreen(colorSchemes: [.light])
    }
  }

  extension RegistrationStep2ViewModel {
    static let mock = RegistrationStep2ViewModel(
      //api: MockRegistrationService(),
      email: "m@d.com",
      password: "testing0"
      //showLogin: {},
      //onRegistration: {}
    )
  }
#endif
