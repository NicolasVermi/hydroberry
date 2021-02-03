//
//  LoginViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 07/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Combine
import Foundation
import FirebaseAnalytics
import FirebaseAuth

final class LoginViewModel: ObservableObject {

  private var cancellable: Cancellable?
  @Published var success: Bool = false
  @Published var isLoading: Bool = false
  @Published var error: LoginViewError?
  @Published var showErrorAlert = false
  @Published var errorType = ""

  init() {}

  func submit(email: String, password: String) {
    cancellable?.cancel()
    error = nil

    guard email.isNotEmptyUserInput else {
      error = .missingEmail
      return
    }
    guard password.isNotEmptyUserInput else {
      error = .missingPassword
      return
    }
    
    //let email = "example@gmail.com"
    //let password = "testtest"
    
    Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
      if let error = error as? NSError {
        switch AuthErrorCode(rawValue: error.code) {
        case .operationNotAllowed:
            print("operationNotAllowed")
            self.showErrorAlert = true
            self.errorType = "Operazione non permessa"
        case .userDisabled:
            print("userDisabled")
            self.showErrorAlert = true
            self.errorType = "Utente disabilitato"
        case .wrongPassword:
            print("wrongPassword")
            self.showErrorAlert = true
            self.errorType = "Password errata"
        case .invalidEmail:
            print("invalidMail")
            self.showErrorAlert = true
            self.errorType = "Email non valida"
        default:
            self.showErrorAlert = true
            self.errorType = "Errore: non è presente alcun utente con questa mail"
            print("Error: \(error.localizedDescription)")
        }
      } else {
        print("User signs in successfully")
        self.success = true
        self.showErrorAlert = false

      }
    }
  }
}

enum LoginViewError: Error, Equatable {
  case generic
  case missingEmail
  case missingPassword
}
