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
    /*@Published var idMisurazione = ""
    @Published var ph = 0.0
    @Published var ec = 0.0
    @Published var temperatura = 0.0
    @Published var umidita = 0.0*/
    
    
    private var db = Firestore.firestore()

    
    
    func readData(){

        findCrop{ [weak self] in
            guard let self = self else{ return }

            let misurazioneRef = self.db.collection("misurazioni")
            .whereField("idRaccolto", isEqualTo: self.idRaccolto)
        
        misurazioneRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving raccolti: \(error.debugDescription)")
                return
            }

            guard let lastSnapshot = snapshot.documents.last else {
                print ("The collection is empty.")
                return
            }
        }
        }
    }
        
    
    
    func findCrop(completion: @escaping () -> Void){
        
        
        let idUtente = String(Auth.auth().currentUser?.email ?? "nessuno")
        let raccoltiRef = db.collection("raccolti")
            .whereField("idUtente", isEqualTo: idUtente )
            .whereField("selezionato", isEqualTo: true)
        
        raccoltiRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving raccolti: \(error.debugDescription)")
                return
            }

            guard let lastSnapshot = snapshot.documents.last else {
                print ("The collection is empty.")
                return
            }
 
            self.idRaccolto = lastSnapshot.documentID
            self.utentiAutorizzati = lastSnapshot.get("utentiAutorizzati") as! [String]
            self.nomePianta = lastSnapshot.get("nomePianta") as! String

            
            completion()
            print(self.idRaccolto)
        }
       
    }
    
    
    func addAuthorizedPeople(email: String){
        cancellable?.cancel()
        error = nil

        guard email.isNotEmptyUserInput, email.isValidEmail else {
          error = .missingEmail
          return
        }
        var lista = self.utentiAutorizzati
        lista.append(email)
        db.collection("raccolti").document(self.idRaccolto).setData([ "utentiAutorizzati": lista ], merge: true)

    }
    
    enum SystemError: Error, Equatable {
      case emailNotAvailable
      case generic
      case missingEmail

    }
}
