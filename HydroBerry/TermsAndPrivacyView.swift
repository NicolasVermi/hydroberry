//
//  TermsAndPrivacyView.swift
//  Mecha
//
//  Created by Mattia Valzelli on 09/09/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//


import DuckMaUI
import SwiftUI

struct TermsAndPrivacyView: View {
  let showTerms: () -> Void
  let showPrivacyPolicy: () -> Void
  let accept: () -> Void

  var body: some View {
    VStack(alignment: .leading) {
      Group {
        Spacer()

        Image("Group")

        Spacer().frame(height: 32)
      }

      Group {
        Text("Prima di accedere...")
            .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
          .fixedSize(horizontal: false, vertical: true)
          .font(.init(FontTheme.current.bold.title1))
          .multilineTextAlignment(.leading)

        Spacer().frame(height: 10)

        Text("Accetta i termini e condizioni e la privacy policy per poter visualizzare i nostri contenuti")
            .foregroundColor(Color(red:130/255, green: 136/255, blue:148/255))
          .fixedSize(horizontal: false, vertical: true)
          .font(.init(FontTheme.current.semibold.headline))
          .multilineTextAlignment(.leading)
      }

      Spacer().frame(height: 24)

      VStack {
        Button(action: self.showTerms) {
          TermPrivacyRowView(title: "Leggi termini e condizioni")
            .foregroundColor(Color(ColorTheme.current.primary.dark))
        }

        Spacer().frame(height: 5)

        Button(action: self.showPrivacyPolicy) {
          TermPrivacyRowView(title: "Leggi privacy policy")
            .foregroundColor(Color(ColorTheme.current.primary.dark))
        }
      }

      Spacer()

      Button(action: self.accept) {
        UIViewPreview(horizontalHugging: .defaultLow) {
          let button = FullButton()
          button.setTitle("Accetta", for: .normal)
          button.titleLabel?.font = FontTheme.current.semibold.subhead
          button.cornerRadius = .medium
          button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
          return button
        }
      }

      Spacer()
    }
    .padding([.leading, .trailing], 32)
  }
}

private struct TermPrivacyRowView: View {
  let title: String

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(self.title)
          .foregroundColor(Color(ColorTheme.current.black))
          .fixedSize(horizontal: false, vertical: true)
          .font(.init(FontTheme.current.regular.headline))
          .multilineTextAlignment(.leading)
        Spacer()
        Image(systemName: "chevron.right")
      }

      Divider()
    }
    .frame(minHeight: 63)
  }
}

#if DEBUG
  struct TermsAndPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
      TermsAndPrivacyView(showTerms: {}, showPrivacyPolicy: {}, accept: {})
    }
  }
#endif

