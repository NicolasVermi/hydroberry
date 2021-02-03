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
    @Published var raccolti = [""]
    @Published var error: SystemError?
    @Published var raccoltoAttivo = ""
    @Published var raccoltoAttuale = ""
    @Published var active = false
    var lista = [""]
 

    
    private var db = Firestore.firestore()

    
    
    func readDataSystem(raccoltoID: String){
        
        findCropSystem (raccoltoID: raccoltoID){ [weak self] in
            guard let self = self else{ return }
            self.activeOrNot(raccoltoID: raccoltoID)
            
        }
    }
    
    
    
    func deleteAuthPeople(email: String, raccoltoID: String){
        self.readDataForAuth(raccoltoID: raccoltoID) {
            [weak self] in
                guard let self = self else{ return }
            var lista = self.utentiAutorizzati
            lista.removeAll(where: { $0 == email })
            self.db.collection("raccolti").document(self.idRaccolto).setData([ "utentiAutorizzati": lista ], merge: true)
            
        }
    }
    
    
    func readDataForAuth(raccoltoID: String, completion: @escaping () -> Void){
        
        findCropSystem(raccoltoID: raccoltoID) { [weak self] in
            guard let self = self else{ return }
            completion()
        }
    }
    
    
    
   
    
    func findCropSystem(raccoltoID: String, completion: @escaping () -> Void){

            let raccoltiRef = self.db.collection("raccolti").document(raccoltoID)
            print("raccolto ID")
            print(raccoltoID)
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

    
    
    func addAuthorizedPeople(email: String){
    
        cancellable?.cancel()
        
        error = nil

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
    
        
        let utentiRef = db.collection("utenti").document(email)
        
        utentiRef.getDocument { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            if snapshot.get("email") != nil
            {
                self.lista.append(email)
                self.db.collection("raccolti").document(self.idRaccolto).setData([ "utentiAutorizzati": self.lista ], merge: true)
                
                print(self.lista)
                
            }else{
                
                print("utenteInesistente")
                self.error = .notRegisteredAccount

            }
            print("sono dentro")
        }

     
    }
    
    
    
    func elimina(raccoltoID: String){
        findCropSystem (raccoltoID: raccoltoID){ [weak self] in
            guard let self = self else{ return }
            let utente = Auth.auth().currentUser?.email ?? "nessuno"
            let utenteRef = self.db.collection("utenti").document(utente)
            utenteRef.addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {
                    print("Error retreving raccolti: \(error.debugDescription)")
                    return
                }
            self.raccolti = snapshot.get("raccolti") as! [String]
            self.raccolti.removeAll(where: { $0 == raccoltoID })
            self.db.collection("utenti").document(utente).setData([ "raccolti": self.raccolti ], merge: true)

        }
    }
    }
    
    
    
    

    
    func addListaRaccolti(idUtente: String)
    {
        findRaccolti(idUtente: idUtente){ [weak self] in
            guard let self = self else{ return }
            if self.raccolti != [""]
            {
                self.db.collection("utenti").document(idUtente).setData(["raccolti": self.raccolti], merge: true)
                print("ho aggiunto il raccolto all'utente")
            }

        }
    }
    
    
    func findRaccolti(idUtente: String ,completion: @escaping () -> Void) {
        
        let utentiRef = db.collection("utenti").document(idUtente)
        
        utentiRef.getDocument { (snapshot, error) in
            guard let snapshot = snapshot else {
                return
                print("utenteInesistente")
            }
            
            if snapshot.get("raccolti") != nil
            {
                
                self.raccolti = snapshot.get("raccolti") as! [String]
                self.raccolti.append(self.idRaccolto)
            }else{
                print("snap nullo")
            }
            
            completion()
        }
    }
    

    func activeOrNot(raccoltoID: String){
        let utente = Auth.auth().currentUser?.email ?? "nessuno"
        let utentiRef = self.db.collection("utenti").document(utente)

        utentiRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving raccolti: \(error.debugDescription)")
                return
            }
        self.raccoltoAttuale = snapshot.get("raccoltoAttivo") as! String
            if self.raccoltoAttuale == raccoltoID{
                self.active = true
            }
        }
    }
    
    func activeSystem(raccoltoID: String){
        let utente = Auth.auth().currentUser?.email ?? "nessuno"
        self.db.collection("utenti").document(utente).setData(["raccoltoAttivo":raccoltoID], merge: true)

    }
    
    //---------------------------------------------------------------------------------------------------------------
    
    enum SystemError: Error, Equatable {
      case emailNotAvailable
      case generic
      case missingEmail
      case notRegisteredAccount

    }
}


