//
//  ForgotPasswordStep1ViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 19/01/21.
//


import Combine
import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseAuth


final class ForgotPasswordStep1ViewModel: ObservableObject {
  


    
  private var cancellable: AnyCancellable?

  @Published var isLoading = false
  //@Published var error: RegistrationStep2Error?
  @Published var errorType = ""
  @Published var success = false
  @Published var showAlert = false


    func passwordRecovery(email: String) {

    Auth.auth().sendPasswordReset(withEmail: email) { (error) in
      if let error = error as? NSError {
        switch AuthErrorCode(rawValue: error.code) {
        case .userNotFound:
            print("Utente non trovato")
            self.errorType = "Utente non trovato"
            self.showAlert = true
          // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
        case .invalidEmail:
            print("Formato mail invalido")
            self.errorType = "Formato mail invalido"
            self.showAlert = true
          // Error: The email address is badly formatted.
        case .invalidRecipientEmail:
            print("Mail non valida")
            self.errorType = "Mail non valida"
            self.showAlert = true
          // Error: Indicates an invalid recipient email was sent in the request.
        case .invalidSender:
            print("Mail non valida")
            self.errorType = "Mail non valida"
            self.showAlert = true
          // Error: Indicates an invalid sender email is set in the console for this action.
        case .invalidMessagePayload:
            print("Formato mail invalido")
            self.errorType = "Formato mail invalido"
            self.showAlert = true
          // Error: Indicates an invalid email template for sending update email.
        default:
            self.errorType = "Error message: \(error.localizedDescription)"
            self.showAlert = true
          print("Error message: \(error.localizedDescription)")
        }
      } else {
        print("Reset password email has been successfully sent")
        self.errorType = "Reset password email has been successfully sent"
        self.showAlert = true
        self.success = true
      }
    }
    }

}


