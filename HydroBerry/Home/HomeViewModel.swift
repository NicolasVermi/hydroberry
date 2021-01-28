//
//  HomeViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 22/01/21.
//

import Foundation
import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth



final class HomeViewModel: ObservableObject{

    private var cancellable: AnyCancellable?

    @Published var idRaccolto = ""
    @Published var idMisurazione = ""
    @Published var ph = 0.0
    @Published var ec = 0.0
    @Published var temperatura = 0.0
    @Published var umidita = 0.0
    
    
    
    private var db = Firestore.firestore()

    func isLogged() -> Bool{
        let idUtente = String(Auth.auth().currentUser?.email ?? "nessuno")
        if idUtente == "nessuno"{
            return false
        }else{
            return true
        }
    }
    
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
 
            self.idMisurazione = lastSnapshot.documentID
            self.temperatura = lastSnapshot.get("temperatura") as! Double
            self.ph = lastSnapshot.get("ph") as! Double
            self.ec = lastSnapshot.get("ec") as! Double
            self.umidita = lastSnapshot.get("umidita") as! Double
            print(self.idMisurazione)
        }
        }
    }
        
    
    
    func findCrop(completion: @escaping () -> Void){
        
        
        let idUtente = String(Auth.auth().currentUser?.email ?? "nessuno")
        let raccoltiRef = db.collection("utenti")
            .whereField("email", isEqualTo: idUtente )
        
        raccoltiRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving raccolti: \(error.debugDescription)")
                return
            }

            guard let lastSnapshot = snapshot.documents.last else {
                print ("The collection is empty.")
                return
            }
 
            self.idRaccolto = lastSnapshot.get("raccoltoAttivo")! as! String
            completion()
            print(self.idRaccolto)
        }
       
    }
}
