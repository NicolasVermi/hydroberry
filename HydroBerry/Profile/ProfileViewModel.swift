//
//  ProfileViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 21/01/21.
//

import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth


final class ProfileViewModel: ObservableObject{
    
    private var email: String
    private var cancellable: AnyCancellable?
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var raccolti = [""]
    @Published var showLogin = false
    
    @Published var error: EditProfileError?
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var emailOrPasswordError = ""
    @Published var successEmail = false
    @Published var successPassword = false
    @Published var success = false
    @Published var showAlert = false
    @Published var refresh = false
    
    
    private var db = Firestore.firestore()

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
    
    func updateFirestore(email: String, firstName: String, lastName: String){
        
        db.collection("utenti").document(email).setData([ "firstName": firstName, "lastName":lastName ], merge: true)

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
    //private var db = Firestore.firestore()
    
    init(email:String) {
        self.email = email
    }
    
    func logout(){
        self.showLogin = true
    }
    
    func readData(){
        let utenteRef = db.collection("utenti").document(email)
        utenteRef.getDocument { [self] (document, error) in

            if let document = document, document.exists {
                self.firstName = document.get("firstName")! as! String
                self.lastName = document.get("lastName")! as! String
                let raccolti = document.get("raccolti")! as! [Any]
                print("Raccolti:")
                print(raccolti)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
}
