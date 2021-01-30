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
    var lista = [""]
 

    
    private var db = Firestore.firestore()

    
    
    func readDataSystem(){
        
        findCropSystem { [weak self] in
            guard let self = self else{ return }

        }
    }
    
    
    
    func deleteAuthPeople(email: String){
        self.readDataForAuth {
            [weak self] in
                guard let self = self else{ return }
            var lista = self.utentiAutorizzati
            lista.removeAll(where: { $0 == email })
            self.db.collection("raccolti").document(self.idRaccolto).setData([ "utentiAutorizzati": lista ], merge: true)
            
        }
    }
    
    
    func readDataForAuth(completion: @escaping () -> Void){
        
        findCropSystem { [weak self] in
            guard let self = self else{ return }
            completion()
        }
    }
    
    // non devo andare a modificare il raccolto attivo ma quello cliccato nella systema view
    
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
        
            // potrei eliminare dal principio fino a qua probabilmente se passassi il valore
            
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
    
    

    

    
    
    //---------------------------------------------------------------------------------------------------------
    // da modificare
    // cosa fare: praticamente bisogna andare ad eliminare il sistema che viene attualmente visualizzato che non è per forza quello attivo. Qualora fosse pure quello attivo bisogna andare a eliminare dagli attivi quello che è stato eliminato
    // questo al momento non fa nulla ed è solo la copia di quello fatto di la
    
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
    
    //---------------------------------------------------------------------------------------------------------------
    // aggiungere funzionalità per aggiungere raccolto cliccando su invia alla lista raccolti dell'utente della mail inserita
    
    enum SystemError: Error, Equatable {
      case emailNotAvailable
      case generic
      case missingEmail
      case notRegisteredAccount

    }
}


