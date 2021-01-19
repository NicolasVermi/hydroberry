//
//  RegistrationStep2ViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 08/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//
//  Modified by Nicolas Vermi on 12/01/2021

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
  @Published var errorType = ""
  @Published var success = false
  @Published var showAlert = false

  init(
    email: String,
    password: String
  ) {
    self.email = email
    self.password = password
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
            print("operationNotAllowed")
            self.errorType = "Operazione non disponibile"
            self.showAlert = true
        case .emailAlreadyInUse:
            print("emailAlreadyInUse")
            self.errorType = "Email già in uso"
            self.showAlert = true
          // Error: The email address is already in use by another account.
        case .invalidEmail:
            print("invalidMail")
            self.errorType = "Email non valida"
            self.showAlert = true
          // Error: The email address is badly formatted.
        case .weakPassword:
            print("weakPassword")
            self.errorType = "Password debole"
            self.showAlert = true
          // Error: The password must be 6 characters long or more.
        default:
            self.errorType = "Error: \(error.localizedDescription)"
            print("Error: \(error.localizedDescription)")
            self.showAlert = true
        }
      } else {
        print("User signs up successfully")
        self.success = true
        self.showAlert = false
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
