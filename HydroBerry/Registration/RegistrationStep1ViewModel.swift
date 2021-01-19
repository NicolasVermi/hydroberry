//
//  RegistrationStep1ViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 08/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//
//  Modified by Nicolas Vermi on 12/01/2021


import Combine
import Foundation

final class RegistrationStep1ViewModel: ObservableObject {


  private var cancellable: AnyCancellable?

  @Published var isLoading = false
  @Published var error: RegistrationStep1Error?
  @Published var showErrorAlert = false
  @Published var mustAcceptPolicy = false

  func submitCheckEmail(
    _ email: String, password: String, acceptedPolicy: Bool, acceptedTerms: Bool
  ) {
    cancellable?.cancel()
    error = nil

    guard email.isNotEmptyUserInput, email.isValidEmail else {
      error = .missingEmail
      return
    }

    let validator = PasswordValidator(for: password)
    guard validator.valid else {
      error = .password
      return
    }

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
