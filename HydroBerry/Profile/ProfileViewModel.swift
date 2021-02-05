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
    @Published var nomePianta = ""
    @Published var nomeRaccolto = ""
    @Published var utentiAutorizzati = [""]
    @Published var idRaccolto = ""
    @Published var listaCrops = [Impianto]()

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
    
    func updateAll(firstName: String, lastName: String, password: String, email: String,completion: @escaping () -> Void){
        updateName(firstName: firstName, lastName: lastName)
        updateEmail(email: email)
        updatePassword(password: password)
        completion()
    }
    
    
    func updateUserData(firstName: String, lastName: String, password: String, email: String){
        updateAll(firstName: firstName, lastName: lastName, password: password, email: email){
            [weak self] in
            guard let self = self else{ return }
            self.db.collection("utenti").document(email).setData([ "firstName": firstName, "lastName":lastName ], merge: true)
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
        print("email " + email)
        print("self.email " + email)
        
        if (email != ""){
            if ( email == self.email){
                self.successPassword = true
                self.emailError = "Non cambiata"
                print("email coincidono")
            }else{
                print("email diversa da self email")
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
                    print("Update email is successful")
                  }
                })

            }
          
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
    
    init(email:String) {
        self.email = email
    }
    
    func logout(){
        self.showLogin = true
    }
    
    func readData(){
        self.raccolti = [""]

        findUserSystem { [weak self] in
            guard let self = self else{ return }
            self.listaCrops = []
            for i in self.raccolti{
                
                self.findCrop(raccolto: i) { [weak self] in
                    guard let self = self else{ return }
                    
                    var crop = Impianto(idRaccolto: self.idRaccolto, nomeRaccolto: self.nomeRaccolto, nomePianta: self.nomePianta, listaUtentiAutorizzati: self.utentiAutorizzati)
                    
                    self.listaCrops.append(crop)
                }
            }
        }

    }
    
    
    func findUserSystem(completion: @escaping () -> Void){
        let utenteRef = db.collection("utenti").document(email)
        utenteRef.addSnapshotListener { [self] (document, error) in

            if let document = document, document.exists {
                self.firstName = document.get("firstName") as! String
                self.lastName = document.get("lastName") as! String
                self.raccolti = document.get("raccolti") as! [String]
                print("Raccolti:")
                print(self.raccolti)
            } else {
                print("Document does not exist")
            }
            completion()

        }
    }
    
    func findCrop(raccolto: String, completion: @escaping () -> Void){
        
        let raccoltoRef = db.collection("raccolti").document(raccolto)
        raccoltoRef.addSnapshotListener { [self] (document, error) in

            if let document = document, document.exists {
                
                self.nomePianta = document.get("nomePianta") as! String
                self.nomeRaccolto = document.get("nomeSistema") as! String
                self.utentiAutorizzati = document.get("utentiAutorizzati") as! [String]
                self.idRaccolto = document.documentID
                print(self.nomePianta)
                print(self.nomeRaccolto)
                print(self.utentiAutorizzati)
            
            } else {
                print("Document does not exist")
            }
            completion()
        }
    }
    
}

struct Impianto{
    let idRaccolto: String
    let nomeRaccolto: String
    let nomePianta: String
    let listaUtentiAutorizzati: [String]

}
