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
    
    private var db = Firestore.firestore()

    func readData(){
        //isLoading = true
        findCrop{ [weak self] in
            guard let self = self else{ return }
            self.findTime {
                [weak self] in
                  guard let self = self else{ return }
                   // self.isLoading = false
            }

        }
    }
    
    func findTime(completion: @escaping () -> Void){
        let piantaRef = self.db.collection("piante").document(self.nomePianta)
        piantaRef.getDocument { [self] (document, error) in
            
            if let document = document, document.exists {

                self.tempoCrescitaMinimo = document.get("tempoCrescitaMinimo")! as! Int
                self.tempoCrescitaMassimo = document.get("tempoCrescitaMassimo")! as! Int
            } else {
                print("Document does not exist")
            }
        }
        completion()
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
 
            self.nomePianta = lastSnapshot.get("nomePianta") as! String
            let ts = lastSnapshot.get("dataInizio") as! Timestamp
            let aDate = ts.dateValue()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            let formattedTimeZoneStr = formatter.string(from: aDate)
            //formatter.date(from: formattedTimeZoneStr)
            self.delta = Int(round((Date().timeIntervalSinceReferenceDate - aDate.timeIntervalSinceReferenceDate)/86400))
            
            print(formattedTimeZoneStr)
            print("delta " + String(self.delta))
            print(self.nomePianta)
            
            completion()
        }
       
    }

}
