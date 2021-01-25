//
//  informationViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 21/01/21.
//


import Combine
import Foundation
import FirebaseFirestore


final class InformationViewModel: ObservableObject{
    private var nome: String
    @Published var nomeScientifico = ""
    @Published var temperaturaMinima = 0.0
    @Published var temperaturaMassima = 0.0
    @Published var ecMassimo = 0.0
    @Published var ecMinimo = 0.0
    @Published var umiditaMassima = 0.0
    @Published var umiditaMinima = 0.0
    @Published var phMassimo = 0.0
    @Published var phMinimo = 0.0
    @Published var oreLuce = 0
    @Published var tempoCrescitaMassimo = 0
    @Published var tempoCrescitaMinimo = 0
    
    private var db = Firestore.firestore()
    
    init(nome:String) {
        self.nome = nome
    }
    
    func readData(){
        let piantaRef = db.collection("piante").document(nome)
        //print(nome)
        piantaRef.getDocument { [self] (document, error) in
            
            if let document = document, document.exists {
                self.nomeScientifico = document.get("nomeScientifico")! as! String
                self.temperaturaMinima = document.get("temperaturaMinima")! as! Double
                self.temperaturaMassima = document.get("temperaturaMassima")! as! Double
                self.ecMinimo = document.get("ecMinimo")! as! Double
                self.ecMassimo = document.get("ecMassimo")! as! Double
                self.umiditaMinima = document.get("umiditaMinima")! as! Double
                self.umiditaMassima = document.get("umiditaMassima")! as! Double
                self.phMinimo = document.get("phMinimo")! as! Double
                self.phMassimo = document.get("phMassimo")! as! Double
                self.oreLuce = document.get("oreLuce")! as! Int
                self.tempoCrescitaMinimo = document.get("tempoCrescitaMinimo")! as! Int
                self.tempoCrescitaMassimo = document.get("tempoCrescitaMassimo")! as! Int
                print("il documento esiste, printo per prova il relativo nome scientifico")
                print(self.nomeScientifico)
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
}
