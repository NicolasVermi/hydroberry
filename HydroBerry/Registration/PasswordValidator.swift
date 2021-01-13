//
//  PasswordValidator.swift
//  Mecha
//
//  Created by Mattia Valzelli on 07/05/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Foundation

struct PasswordValidator {
  let strength: Int
  let isLongerThan8: Bool
  let isMultiCase: Bool
  let hasDigit: Bool

  var level: PasswordStrenght {
    switch strength {
    case Int.min ..< PasswordStrenght.goodThreshold:
      return .weak
    case PasswordStrenght.goodThreshold ..< PasswordStrenght.solidThreshold:
      return .good
    case PasswordStrenght.solidThreshold ... Int.max:
      return .solid
    default:
      preconditionFailure("Should be unreachable")
    }
  }

  var valid: Bool { level >= .good && isLongerThan8 && isMultiCase && hasDigit }

  init(for string: String) {
    self.strength = Int(String.strenghtAsPassword(string))
    self.isLongerThan8 = string.count >= 8
    self.isMultiCase =
      string.contains(where: \.isLowercase) && string.contains(where: \.isUppercase)
    self.hasDigit = string.contains(where: \.isNumber)
  }
}

extension PasswordValidator {
  enum PasswordStrenght: Comparable {
    fileprivate static let weakThreshold = 1
    fileprivate static let goodThreshold = 110
    fileprivate static let solidThreshold = 250

    case weak
    case good
    case solid

    static func < (lhs: PasswordStrenght, rhs: PasswordStrenght) -> Bool {
      switch (lhs, rhs) {
      case (.weak, .weak), (.good, .good), (.solid, .solid):
        return false
      case (.weak, _):
        return true
      case (.good, .solid):
        return true
      case (.good, _):
        return false
      case (.solid, _):
        return false
      }
    }
  }
}
