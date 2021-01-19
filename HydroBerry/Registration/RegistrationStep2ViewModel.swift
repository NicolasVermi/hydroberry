//
//  RegistrationStep2ViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 08/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Combine
import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseAuth


final class RegistrationStep2ViewModel: ObservableObject {
  private let email: String
  private let password: String


    
  private var cancellable: AnyCancellable?

  @Published var isLoading = false
  @Published var error: RegistrationStep2Error?
  @Published var showErrorAlert = false

  init(
    email: String,
    password: String
    //showLogin: @escaping () -> Void,
    //onRegistration: @escaping () -> Void
  ) {
    self.email = email
    self.password = password
    //self.showLogin = showLogin
    //self.onRegistration = onRegistration
  }

  func signup(firstName: String, lastName: String) {
    cancellable?.cancel()
    error = nil
    

    guard firstName.isNotEmptyUserInput else {
      error = .missingFirstName
      return
    }

    guard lastName.isNotEmptyUserInput else {
      error = .missingLastName
      return
    }

    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      if let error = error as? NSError {
        switch AuthErrorCode(rawValue: error.code) {
        case .operationNotAllowed:
            print("operationNotAllowew")
          // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
        case .emailAlreadyInUse:
            print("emailAlreadyInUse")
          // Error: The email address is already in use by another account.
        case .invalidEmail:
            print("invalidMail")
          // Error: The email address is badly formatted.
        case .weakPassword:
            print("weakPassword")
          // Error: The password must be 6 characters long or more.
        default:
            print("Error: \(error.localizedDescription)")
        }
      } else {
        print("User signs up successfully")
        let newUserInfo = Auth.auth().currentUser
        let email = newUserInfo?.email
      }
    }

  }
}

enum RegistrationStep2Error: Error, Equatable {
  case generic
  case missingFirstName
  case missingLastName
}
