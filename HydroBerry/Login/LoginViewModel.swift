//
//  LoginViewModel.swift
//  Mecha
//
//  Created by Mattia Valzelli on 07/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Combine
import Foundation

final class LoginViewModel: ObservableObject {
  //private let api: MechaLoginService
  //private let onLogin: () -> Void

  private var cancellable: Cancellable?

  @Published var isLoading: Bool = false
  @Published var error: LoginViewError?
  @Published var showErrorAlert = false

  init(
    //api: MechaLoginService, onLogin: @escaping () -> Void
  ) {
    //self.api = api
    //self.onLogin = onLogin
  }

  func submit(email: String, password: String) {
    cancellable?.cancel()
    error = nil

    guard email.isNotEmptyUserInput else {
      error = .missingEmail
      return
    }
    guard password.isNotEmptyUserInput else {
      error = .missingPassword
      return
    }

 /*   cancellable = api.login(email: email, password: password)
      .receive(on: DispatchQueue.main)
      .handleEvents(
        receiveSubscription: { [weak self] _ in self?.isLoading = true },
        receiveCompletion: { [weak self] completion in
          self?.isLoading = false
          if case .failure = completion {
            self?.showErrorAlert = true
            self?.error = .generic
          } else if self?.error == nil {
            self?.onLogin()
          }
        },
        receiveCancel: { [weak self] in self?.isLoading = false }
      )
      .sink(receiveCompletion: { _ in }, receiveValue: { _ in })*/
  }
}

enum LoginViewError: Error, Equatable {
  case generic
  case missingEmail
  case missingPassword
}
