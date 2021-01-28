//
//  SystemViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 25/01/21.
//


import Foundation
import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth



final class SystemViewModel: ObservableObject{

    private var cancellable: AnyCancellable?

    @Published var idRaccolto = ""
    @Published var nomePianta = ""
    @Published var utentiAutorizzati = [""]
    @Published var error: SystemError?
    @Published var raccoltoAttivo = ""
    var lista = [""]
 

    
    private var db = Firestore.firestore()

    
    
    func readDataSystem(){
        
        findCropSystem { [weak self] in
            guard let self = self else{ return }

        }
    }
        
    
    
    func findCropSystem(completion: @escaping () -> Void){
 
        let idUtente = String(Auth.auth().currentUser?.email ?? "nessuno")
        let utentiRef = db.collection("utenti")
            .whereField("email", isEqualTo: idUtente )
        
        utentiRef.addSnapshotListener { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error retreving raccolti: \(error.debugDescription)")
                return
            }
            
            guard let lastSnapshot = snapshot.documents.last else {
                print ("The collection is empty.")
                return
            }
            
            self.raccoltoAttivo = lastSnapshot.get("raccoltoAttivo") as! String
        
            print("Raccolto attivoo  " + self.raccoltoAttivo)
            self.idRaccolto = self.raccoltoAttivo
                        
            let raccoltiRef = self.db.collection("raccolti").document(self.raccoltoAttivo)
            
            raccoltiRef.addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Error retreving raccolti: \(error.debugDescription)")
                    return
                }

            self.nomePianta = snapshot.get("nomePianta") as! String
            self.utentiAutorizzati = snapshot.get("utentiAutorizzati") as! [String]
            //print(self.nomePianta)
            print("sono dentro il findcropsystem e leggo tra le altre cose gli utenti")
            completion()
            }
        }
    }
    
    func elimina(){
        db.collection("raccolti").document(self.idRaccolto).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    
    func addAuthorizedPeople(email: String){
    
        cancellable?.cancel()
        
        error = nil
       // problema potrebbe essere che sono dentro qui
        
        //self.readDataForAuth {
            
           /* [weak self] in
                guard let self = self else{ return }*/
                guard email.isNotEmptyUserInput, email.isValidEmail else {
                    self.error = .missingEmail
                  return
                }
                self.lista = self.utentiAutorizzati
                print("lista pre add  ")
                print(self.lista)
                
                guard !self.lista.contains(email) else {
                    self.error = .emailNotAvailable
                    return
                }
            
                self.lista.append(email)
                print("lista post add  ")
                print(self.lista)

                self.db.collection("raccolti").document(self.idRaccolto).setData([ "utentiAutorizzati": self.lista ], merge: true)
                //self.lista = [""]
        //}
    }
    
    
    func readDataForAuth(completion: @escaping () -> Void){
        
        findCropSystem { [weak self] in
            guard let self = self else{ return }
            completion()
        }
    }
    
    func deleteAuthPeople(email: String){
        self.readDataForAuth {
            [weak self] in
                guard let self = self else{ return }
            //print("email: " + email)
            var lista = self.utentiAutorizzati
            lista.removeAll(where: { $0 == email })
            //print("lista in delete:")
            //print(lista)
            self.db.collection("raccolti").document(self.idRaccolto).setData([ "utentiAutorizzati": lista ], merge: true)
            
        }
    }
    
    enum SystemError: Error, Equatable {
      case emailNotAvailable
      case generic
      case missingEmail

    }
}


