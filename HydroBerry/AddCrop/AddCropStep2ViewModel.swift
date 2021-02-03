//
//  AddCropStep2ViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 21/01/21.
//


import Combine
import Foundation
import FirebaseFirestore



final class AddCropStep2ViewModel: ObservableObject{

    private var cancellable: AnyCancellable?

    @Published var isLoading = false
    @Published var error: RegistrationStep2Error?
    @Published var errorType = ""
    @Published var success = false
    @Published var raccolti = []
    @Published var idUtente = ""
    @Published var idRaccolto = ""

    private var db = Firestore.firestore()
      
/*
    func addCrop(idRaccolto: String, nomeSistema: String, dataInizio: Date, etaPiantaInizio: Int, nomePianta: String, idUtente: String) {
      cancellable?.cancel()
      error = nil
      
      let raccoltiRef = db.collection("raccolti")

      raccoltiRef.document(idRaccolto).setData([
          
          "nomeSistema": nomeSistema,
          "dataInizio": dataInizio,
          "etaPiantaInizio": etaPiantaInizio,
          "idUtente": idUtente,
          "nomePianta": nomePianta,
          "utentiAutorizzati": [idUtente]
          ])
        
        
      let utentiRef = db.collection("utenti").document(idUtente)
        
        utentiRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            self.raccolti = snapshot.get("raccolti") as! [String]
            self.raccolti.append(idRaccolto)
            print("sono dentro")
            
        }

        db.collection("utenti").document("example@gmail.com").setData([ "raccolti": raccolti ], merge: true)

    
  }
     */
    
    
    
    
    func addCrop(idRaccolto: String, nomeSistema: String, dataInizio: Date, etaPiantaInizio: Int, nomePianta: String, idUtente: String) {
      cancellable?.cancel()
      error = nil
        self.idUtente = idUtente
        self.idRaccolto = idRaccolto
        
        let raccoltiRef = self.db.collection("raccolti")

        raccoltiRef.document(idRaccolto).setData([
            
            "nomeSistema": nomeSistema,
            "dataInizio": dataInizio,
            "etaPiantaInizio": etaPiantaInizio,
            "idUtente": idUtente,
            "nomePianta": nomePianta,
            "utentiAutorizzati": [idUtente]
            ])

    
  }
    
    func addListaRaccolti(idUtente: String)
    {
        addRaccolti{ [weak self] in
            guard let self = self else{ return }

            self.db.collection("utenti").document(idUtente).setData(["raccolti": self.raccolti], merge: true)
            print("Racolti: ")
            print(self.raccolti)
            print("1")
        }
        //self.db.collection("utenti").document(idUtente).setData(["raccolti": self.raccolti], merge: true)

    }
    
    
    func addRaccolti(completion: @escaping () -> Void) {
        let utentiRef = db.collection("utenti").document(idUtente)
        
        utentiRef.getDocument { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            self.raccolti = snapshot.get("raccolti") as! [String]
            self.raccolti.append(self.idRaccolto)
            print("sono dentro")
            completion()
        }
    }
}
