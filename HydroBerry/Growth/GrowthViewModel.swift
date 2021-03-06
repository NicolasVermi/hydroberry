//
//  GrowthViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 18/01/21.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

final class GrowthViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    @Published var nomePianta = ""
    @Published var dataInizioStringa = ""
    @Published var dataInizio = Data()
    @Published var tempoCrescitaMinimo = 1
    @Published var tempoCrescitaMassimo = 1
    @Published var delta = 0
    @Published var isLoading = false
    @Published var percCompletamento: CGFloat = 0.0
    @Published var raccoltoAttivo = ""
    @Published var etaPiantaInizio = 0

    
    private var db = Firestore.firestore()

    func readData(){
        isLoading = true
        findCrop{ [weak self] in
            guard let self = self else{ return }
            self.findTime {
                [weak self] in
                  guard let self = self else{ return }
                self.handleSuccess()
            }

        }
    }
    
    func handleSuccess() {
        self.isLoading = false
    }
    
    func findTime(completion: @escaping () -> Void){
        print("sono in growthview model")
        let piantaRef = self.db.collection("piante").document(self.nomePianta)
        piantaRef.getDocument { [self] (document, error) in
            
            if let document = document, document.exists {

                self.tempoCrescitaMinimo = document.get("tempoCrescitaMinimo")! as! Int
                self.tempoCrescitaMassimo = document.get("tempoCrescitaMassimo")! as! Int
               
                print("delta " + String(self.delta))
                print("tempo crescita massimo " + String(self.tempoCrescitaMassimo))
                print("percentualecomp")
                print(self.percCompletamento)
                self.percCompletamento = CGFloat (self.delta * 100 / self.tempoCrescitaMassimo )
                print(CGFloat (self.delta * 100 / self.tempoCrescitaMassimo ))
                print(self.percCompletamento)
            } else {
                print("Document does not exist")
            }
        }
        completion()
    }
    
    func findCrop(completion: @escaping () -> Void){
        let idUtente = String(Auth.auth().currentUser?.email ?? "nessuno")
        let utentiRef = db.collection("utenti")
            .whereField("email", isEqualTo: idUtente )
        
        utentiRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error retreving raccolti: \(error.debugDescription)")
                return
            }

            guard let lastSnapshot = snapshot.documents.last else {
                print ("The collection is empty (inside growth view).")
                return
            }
            
            self.raccoltoAttivo = lastSnapshot.get("raccoltoAttivo") as! String
        
            print("Raccolto attivoo  " + self.raccoltoAttivo)
            
            if self.raccoltoAttivo != ""{
            
            let raccoltiRef = self.db.collection("raccolti").document(self.raccoltoAttivo)

                
                raccoltiRef.getDocument { (snapshot, error) in
                    guard let snapshot = snapshot else {
                        print("Error retreving raccolti: \(error.debugDescription)")
                        return
                    }

                self.nomePianta = snapshot.get("nomePianta") as! String
                self.etaPiantaInizio = snapshot.get("etaPiantaInizio") as! Int
                let ts = snapshot.get("dataInizio") as! Timestamp
                let aDate = ts.dateValue()

                    self.delta = Int(round((Date().timeIntervalSinceReferenceDate - aDate.timeIntervalSinceReferenceDate)/86400)) + self.etaPiantaInizio
                
                print(self.nomePianta)
                completion()
            }
            
                
            }

        }
    }

}
