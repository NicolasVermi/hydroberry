//
//  OnboardingStyle.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//


import Foundation

enum OnboardingStyle {
  case skip(() -> Void)
  case registerLogin(register: () -> Void, login: () -> Void)

  // swiftlint:disable let_var_whitespace
  @available(
    swift,
    deprecated: 5.3,
    message: "Workaround for closure containing control flow statement"
  )
  var skipAction: (() -> Void)? {
    guard case let .skip(action) = self else { return nil }
    return action
  }

  @available(
    swift,
    deprecated: 5.3,
    message: "Workaround for closure containing control flow statement"
  )
  var registerLoginAction: (register: () -> Void, login: () -> Void)? {
    guard case let .registerLogin(register, login) = self else { return nil }
    return (register, login)
  }

  // swiftlint:enable let_var_whitespace
}

