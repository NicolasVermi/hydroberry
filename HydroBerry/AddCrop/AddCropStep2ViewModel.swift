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
    @Published var showAlert = false
    private var db = Firestore.firestore()
      

    func addCrop(idRaccolto: String, nomeSistema: String, dataInizio: Date, etaPiantaInizio: Int, nomePianta: String, idUtente: String) {
      cancellable?.cancel()
      error = nil
      
      let utentiRef = db.collection("raccolti")

      utentiRef.document(idRaccolto).setData([
          
          "nomeSistema": nomeSistema,
          "dataInizio": dataInizio,
          "etaPiantaInizio": etaPiantaInizio,
          "idUtente": idUtente,
          "nomePianta": nomePianta
          ])
      
    
  }
}
