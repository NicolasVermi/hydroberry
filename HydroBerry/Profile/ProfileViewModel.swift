//
//  ProfileViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 21/01/21.
//

import Combine
import Foundation
import FirebaseFirestore


final class ProfileViewModel: ObservableObject{
    private var email: String
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var raccolti = [""]
    private var db = Firestore.firestore()
    
    init(email:String) {
        self.email = email
    }
    
    func readData(){
        let utenteRef = db.collection("utenti").document(email)
        utenteRef.getDocument { [self] (document, error) in
            
            if let document = document, document.exists {
                self.firstName = document.get("firstName")! as! String
                self.lastName = document.get("lastName")! as! String
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
}
