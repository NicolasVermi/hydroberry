//
//  EditProfileViewModel.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 15/01/21.

import Foundation
import Combine

final public class EditProfileViewModel: ObservableObject {
    //private let api: MechaRegistrationService
    //let showPrivacy: () -> Void
    //let showTerms: () -> Void
    //private let nextStep: (String, String) -> Void
    //let showLogin: () -> Void

    //private var cancellable: AnyCancellable?

    @Published var isLoading = false
    @Published var error: EditProfileError?
    @Published var showErrorAlert = false
    @Published var mustAcceptPolicy = false

    //init(
      //api: MechaRegistrationService,
      //showPrivacy: @escaping () -> Void,
      //showTerms: @escaping () -> Void,
      //nextStep: @escaping (String, String) -> Void,
      //showLogin: @escaping () -> Void
    //) {
      //self.api = api
      //self.showPrivacy = showPrivacy
      //self.showTerms = showTerms
      //self.nextStep = nextStep
      //self.showLogin = showLogin
    //}
    
    enum EditProfileError: Error, Equatable {
      case emailNotAvailable
      case generic
      case missingEmail
      case password
      case missingFirstName
      case missingLastName
    
}


}
