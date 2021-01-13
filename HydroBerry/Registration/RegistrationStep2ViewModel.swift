//
//  RegistrationStep2ViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 08/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Combine
import Foundation

final class RegistrationStep2ViewModel: ObservableObject {
  
  private let email: String
  private let password: String
  //let showLogin: () -> Void
  //private let onRegistration: () -> Void

  private var cancellable: AnyCancellable?

  @Published var isLoading = false
  @Published var error: RegistrationStep2Error?
  @Published var showErrorAlert = false

  init(
    email: String,
    password: String
    //showLogin: @escaping () -> Void,
    //onRegistration: @escaping () -> Void
  ) {
    self.email = email
    self.password = password
    //self.showLogin = showLogin
    //self.onRegistration = onRegistration
  }

  func signup(firstName: String, lastName: String) {
    cancellable?.cancel()
    error = nil

    guard firstName.isNotEmptyUserInput else {
      error = .missingFirstName
      return
    }

    guard lastName.isNotEmptyUserInput else {
      error = .missingLastName
      return
    }

    /*
    cancellable = api.signup(
      email: email, password: password, firstName: firstName, lastName: lastName
    )
    .receive(on: DispatchQueue.main)
    .handleEvents(
      receiveSubscription: { [weak self] _ in self?.isLoading = true },
      receiveCompletion: { [weak self] completion in
        self?.isLoading = false
        if case .failure = completion {
          self?.error = .generic
          self?.showErrorAlert = true
        } else {
          self?.onRegistration()
        }
      },
      receiveCancel: { [weak self] in self?.isLoading = false }
    )
    .sink(
      receiveCompletion: { _ in },
      receiveValue: { _ in }
    )*/
  }
}

enum RegistrationStep2Error: Error, Equatable {
  case generic
  case missingFirstName
  case missingLastName
}
