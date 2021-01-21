//
//  EditProfileViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 15/01/21.

import Combine
import Foundation
import UIKit
import FirebaseAnalytics
import FirebaseAuth

final public class EditProfileViewModel: ObservableObject {
    //private let api: MechaRegistrationService
    //let showPrivacy: () -> Void
    //let showTerms: () -> Void
    //private let nextStep: (String, String) -> Void
    //let showLogin: () -> Void

    private var cancellable: AnyCancellable?

    //@Published var isLoading = false
    @Published var error: EditProfileError?
    //@Published var showErrorAlert = false
    //@Published var mustAcceptPolicy = false
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var emailOrPasswordError = ""
    @Published var successEmail = false
    @Published var successPassword = false
    @Published var success = false
    @Published var showAlert = false

    func updateName(firstName: String, lastName: String) {
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
        
    }
    

    
    func updatePassword(password: String){
        if password != ""{
            Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
              if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                case .userDisabled:
                    self.successPassword = false
                    print("Utente disabilitato")
                    self.passwordError = "Utente disabilitato"
                case .weakPassword:
                    self.successPassword = false
                    print("Password debole")
                    self.passwordError = "Password debole"
                case .operationNotAllowed:
                    self.successPassword = false
                    print("Operazione non permessa")
                    self.passwordError = "Operazione non permessa"

                case .requiresRecentLogin: break

                default:
                    self.successPassword = false
                    print("Error message: \(error.localizedDescription)")
                    self.passwordError = "Error message: \(error.localizedDescription)"
                }
              } else {
                self.passwordError = "Operazione eseguita con successo"
                print("User update successfully")
                self.successPassword = true
              }
            })
            
        }else {
            self.successPassword = true
            self.passwordError = "Non cambiata"
        }
        showAlert = true
            }
    
    
    func updateEmail(email: String) {
        if email != ""{
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .invalidRecipientEmail:
                self.successEmail = false
                self.emailError = "Indicates an invalid recipient email was sent in the request."
              print("Indicates an invalid recipient email was sent in the request.")
            case .invalidSender:
                self.successEmail = false
                self.emailError = "Email invalida"
              print("Indicates an invalid sender email is set in the console for this action.")
            case .invalidMessagePayload:
                self.successEmail = false
                self.emailError = "Error"
              // Error: Indicates an invalid email template for sending update email.
              print("Indicates an invalid email template for sending update email.")
            case .emailAlreadyInUse:
                self.successEmail = false
                self.emailError = "Email già in uso"
              print("Email has been already used by another user.")
            case .invalidEmail:
                self.successEmail = false
                self.emailError = "Formato email errato"
              print("Email is not well formatted")
            case .requiresRecentLogin:
                self.successEmail = false
                self.emailError = "Prima fare login"
              print("Updating a user’s password is a security sensitive operation that requires a recent login.")
            default:
                self.emailError = "Error message: \(error.localizedDescription)"
                self.successEmail = false
              print("Error message: \(error.localizedDescription)")
            }
          } else {
            self.emailError = "Operazione eseguita con successo"
            self.successEmail = true
            //print(self.emailError)
            print("Update email is successful")
          }
        })
        }else{
            self.successPassword = true
            self.emailError = "Non cambiata"
        }
        //print("Email error dentro è:")
        //print(self.emailError)
        showAlert = true
    }
    
    
    
    

    

    
    
    

    
    enum EditProfileError: Error, Equatable {
      case emailNotAvailable
      case generic
      case missingEmail
      case password
      case missingFirstName
      case missingLastName
    
}


}
