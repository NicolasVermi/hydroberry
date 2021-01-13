//
//  RegistrationStep1ViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 08/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Combine
import Foundation

final class RegistrationStep1ViewModel: ObservableObject {
  //private let api: MechaRegistrationService
  let showPrivacy: () -> Void
  let showTerms: () -> Void
  private let nextStep: (String, String) -> Void
  let showLogin: () -> Void

  private var cancellable: AnyCancellable?

  @Published var isLoading = false
  @Published var error: RegistrationStep1Error?
  @Published var showErrorAlert = false
  @Published var mustAcceptPolicy = false

  init(
    //api: MechaRegistrationService,
    showPrivacy: @escaping () -> Void,
    showTerms: @escaping () -> Void,
    nextStep: @escaping (String, String) -> Void,
    showLogin: @escaping () -> Void
  ) {
    //self.api = api
    self.showPrivacy = showPrivacy
    self.showTerms = showTerms
    self.nextStep = nextStep
    self.showLogin = showLogin
  }

  func submitCheckEmail(
    _ email: String, password: String, acceptedPolicy: Bool, acceptedTerms: Bool
  ) {
    cancellable?.cancel()
    error = nil

    /*guard email.isNotEmptyUserInput, email.isValidEmail else {
      error = .missingEmail
      return
    }*/

    /*let validator = PasswordValidator(for: password)
    guard validator.valid else {
      error = .password
      return
    }*/

    guard acceptedPolicy else {
      error = .mustAcceptPolicy
      showErrorAlert = true
      return
    }

    guard acceptedTerms else {
      error = .mustAcceptTerms
      showErrorAlert = true
      return
    }

    /*cancellable =
      api
        .checkUnique(email: email.trimmingEmpty)
        .receive(on: DispatchQueue.main)
        .handleEvents(
          receiveSubscription: { [weak self] _ in self?.isLoading = true },
          receiveCompletion: { [weak self] completion in
            self?.isLoading = false
            if case .failure = completion {
              self?.error = .generic
              self?.showErrorAlert = true
            } else if self?.error == nil {
              self?.nextStep(email, password)
            }
          },
          receiveCancel: { [weak self] in self?.isLoading = false }
        )
        .sink(
          receiveCompletion: { _ in },
          receiveValue: { [weak self] mailAvailable in
            if !mailAvailable {
              self?.error = .emailNotAvailable
            }
          }
        )*/
  }
}

enum RegistrationStep1Error: Error, Equatable {
  case emailNotAvailable
  case generic
  case missingEmail
  case password
  case mustAcceptPolicy
  case mustAcceptTerms
}
