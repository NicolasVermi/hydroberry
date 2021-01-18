//
//  PasswordMeterView.swift
//  Mecha
//
//  Created by Mattia Valzelli on 07/05/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import DuckMaUI
import SwiftUI

struct PasswordMeterView: View {
  let validator: PasswordValidator

  init(password: String) {
    self.validator = PasswordValidator(for: password)
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        RoundedRectangle(cornerRadius: 28)
          .fill(
            validator.level >= .weak && validator.strength >= 1
              ? validator.stepColor
              : Color(ColorTheme.current.gray.p100)
          )
          .frame(height: 6)

        RoundedRectangle(cornerRadius: 28)
          .fill(
            validator.level >= .good
              ? validator.stepColor
              : Color(ColorTheme.current.gray.p100)
          )
          .frame(height: 6)

        RoundedRectangle(cornerRadius: 28)
          .fill(
            validator.level >= .solid
              ? validator.stepColor
              : Color(ColorTheme.current.gray.p100)
          )
          .frame(height: 6)
      }.padding(.vertical)
      createRow(text: Text("Almeno 8 caratteri"), valid: \.isLongerThan8)

      createRow(text: Text("Sia maiuscole che minuscole"), valid: \.isMultiCase)

      createRow(text: Text("Almeno un numero"), valid: \.hasDigit)
    }
  }

  private func createRow(
    text: Text,
    valid: KeyPath<PasswordValidator, Bool>
  ) -> some View {
    HStack {

        if validator[keyPath: valid]{
            Image("ic_check_active")
            
        }
            else{
                Image("ic_check")
            }
      text
    }
  }
}

private extension PasswordValidator {
  var stepColor: Color {
    switch level {
    case .weak:
      return Color(ColorTheme.current.danger.p100)
    case .good:
      return Color(ColorTheme.current.warning.p100)
    case .solid:
      return Color(ColorTheme.current.success.p100)
    }
  }
}

#if DEBUG
  struct PasswordMeterView_Previews: PreviewProvider {
    static var previews: some View {
      PasswordMeterView(password: "P1assowrd")
        .previewLayout(.sizeThatFits)
    }
  }
#endif
