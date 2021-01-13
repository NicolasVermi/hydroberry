//
//  String.swift
//  Mecha
//
//  Created by Mattia Valzelli on 09/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import Foundation

extension String {
  var trimmingEmpty: String { trimmingCharacters(in: .whitespacesAndNewlines) }

  var isNotEmptyUserInput: Bool { !trimmingEmpty.isEmpty }

  var isValidEmail: Bool {
    guard isNotEmptyUserInput else { return false }

    guard
      let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    else {
      return false
    }

    let range = NSRange(location: 0, length: trimmingEmpty.count)
    let allMatches = dataDetector.matches(in: trimmingEmpty, options: [], range: range)

    return allMatches.count == 1
      && allMatches.first?.url?.absoluteString.contains("mailto:") == true
  }
}

// MARK: - Password

// swiftlint:disable cyclomatic_complexity identifier_name
extension String {
  static func strenghtAsPassword(_ password: String) -> Double {
    guard password.isNotEmptyUserInput else { return 0 }
    guard let firstChar = password.first else { return 0 }
    guard let lastChar = password.last else { return 0 }
    guard password.count > 1 else { return 0 }

    var strength = 0

    strength += password.count * 4

    let upperCase = password.filter(\.isUppercase).count
    let lowerCase = password.filter(\.isLowercase).count
    let numbers = password.filter(\.isNumber).count
    let symbols = password.filter(\.isSpecialChar).count
    let middleSymbols = password.dropFirst().filter { $0.isSpecialChar || $0.isNumber }.count

    strength += (password.count - upperCase) * 2
    strength += (password.count - lowerCase) * 2
    strength += numbers * 4
    strength += symbols * 6
    strength += middleSymbols * 2

    if password.count == lowerCase + upperCase {
      strength -= password.count
    }

    if password.count == numbers {
      strength -= password.count * 16
    }

    strength -= password.consecutive(satisfying: \.isUppercase) * 2
    strength -= password.consecutive(satisfying: \.isLowercase) * 2
    strength -= password.consecutive(satisfying: \.isNumber) * 2

    let everyCharExceptFirstLowerCase = password.dropFirst().allSatisfy(\.isLowercase)
    if firstChar.isUppercase, everyCharExceptFirstLowerCase {
      strength -= password.count
    }

    let everyCharExceptLastNotASymbol = password.dropLast().allSatisfy(\.isNotSpecialChar)

    if lastChar.isSpecialChar, everyCharExceptLastNotASymbol {
      strength -= password.count
    }

    if let lastNotSymbol = password.last(where: \.isNotSpecialChar), lastNotSymbol.isNumber {
      strength -= password.count
    }

    var doubleValue = Double(strength)

    var repeatedCharactersPenalty: Double = 0.0
    var repeatedCharacters: Int = 0
    password.enumerated().forEach { element in
      var anyRepeated = false
      let (i, charI) = element
      password.enumerated().forEach { element2 in
        let (j, charJ) = element2
        if i != j, charI == charJ {
          anyRepeated = true
          repeatedCharactersPenalty += Double(abs(Int(Double(password.count) / Double(j - i))))
        }
      }
      if anyRepeated {
        repeatedCharacters += 1
        repeatedCharactersPenalty /= Double.maximum(
          Double(password.count) - Double(repeatedCharacters), 1
        )
      }
    }
    doubleValue -= repeatedCharactersPenalty

    doubleValue *= password.entropy()

    return Double.maximum(0.0, doubleValue.rounded())
  }

  private func consecutive(satisfying: KeyPath<Character, Bool>) -> Int {
    (1 ..< count)
      .map { i in
        self[index(startIndex, offsetBy: i - 1)][keyPath: satisfying]
          && self[index(startIndex, offsetBy: i)][keyPath: satisfying]
      }
      .filter { $0 }
      .count
  }

  private func consecutiveRepeatedChars() -> Int {
    let asLowercased = lowercased()
    return (1 ..< count).reduce(0) { count, i in
      let repeated =
        asLowercased[index(startIndex, offsetBy: i - 1)]
          == asLowercased[index(startIndex, offsetBy: i)]
      return count + (repeated ? 1 : 0)
    }
  }

  private func entropy() -> Double {
    reduce(into: [String: Int]()) { cursor, char in cursor[String(char), default: 0] += 1 }
      .values
      .map({ index in Double(index) / Double(self.count) } as (Int) -> Double)
      .map({ p in -p * log2(p) } as (Double) -> Double)
      .reduce(0.0, +)
  }
}

// swiftlint:enable cyclomatic_complexity identifier_name

// MARK: Character - Special password checks

private extension Character {
  var isNotSpecialChar: Bool { !isSpecialChar }
  var isSpecialChar: Bool { !isUppercase && !isLowercase && !isNumber }
}
