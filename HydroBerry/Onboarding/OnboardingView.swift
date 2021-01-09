//
//  OnboardingView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//

/*
import DuckMaUI
import SwiftUI

struct OnboardingView: View {
  let style: OnboardingStyle
  let items: [OnboardingItem]

  private func pageView(
    title: String,
    description: String,
    image: Image?
  ) -> some View {
    VStack(alignment: .leading) {
      Spacer().frame(height: 24)

      if image != nil {
        image!.resizable()
          .aspectRatio(3 / 2, contentMode: .fit)
          .padding([.leading, .trailing], 16)
      } else {
        RoundedRectangle(cornerRadius: 8)
          .foregroundColor(Color(ColorTheme.current.primary.dark))
          .aspectRatio(3 / 2, contentMode: .fit)
          .padding([.leading, .trailing], 16)
      }

      Spacer().frame(height: 24)

      Text(title)
        .fixedSize(horizontal: false, vertical: true)
        .font(Font(FontTheme.current.bold.title1))
        .foregroundColor(Color(ColorTheme.current.black))
        .padding([.leading, .trailing], 16)

      Spacer().frame(height: 8)

      Text(description)
        .fixedSize(horizontal: false, vertical: true)
        .font(Font(FontTheme.current.regular.body))
        .foregroundColor(Color(ColorTheme.current.black))
        .padding([.leading, .trailing], 16)

      Spacer()
    }
  }

  private func skipButton(_ action: @escaping () -> Void) -> some View {
    Button(action: action) {
      UIViewPreview(horizontalHugging: .defaultLow) {
        let button = FullButton()
        button.setTitle(L10n.onboardingSkip, for: .normal)
        button.titleLabel?.font = FontTheme.current.semibold.subhead
        button.cornerRadius = .medium
        return button
      }
    }
    .padding([.leading, .trailing], 16)
  }

  private func registerLogin(
    registerAction: @escaping () -> Void,
    loginAction: @escaping () -> Void
  ) -> some View {
    VStack {
      Button(action: registerAction) {
        UIViewPreview(horizontalHugging: .defaultLow) {
          let button = FullButton()
          button.setTitle(L10n.onboardingSignup, for: .normal)
          button.titleLabel?.font = FontTheme.current.semibold.subhead
          button.cornerRadius = .medium
          return button
        }
      }

      Spacer().frame(height: 24)

      Button(action: loginAction) {
        Text("onboarding_login")
          .foregroundColor(Color(ColorTheme.current.secondary.dark))
          .fixedSize(horizontal: false, vertical: true)
          .font(.init(FontTheme.current.semibold.footnote))
          .multilineTextAlignment(.center)
      }
    }
    .padding([.leading, .trailing], 16)
  }

  var body: some View {
    VStack {
      if !self.items.isEmpty {
        PagerView(
          self.items.map { item in
            self.pageView(title: item.title, description: item.description, image: item.image)
          }
        )
      }

      Spacer()

      self.style.skipAction.map(self.skipButton(_:))
      self.style.registerLoginAction.map { register, login in
        self.registerLogin(registerAction: register, loginAction: login)
      }

      Spacer().frame(height: 24)
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static let mocks = [
    OnboardingItem(title: "Test 1", description: "Descrizione 1"),
    OnboardingItem(title: "Test 2", description: "Descrizione 2"),
    OnboardingItem(title: "Test 3", description: "Descrizione 3"),
    OnboardingItem(title: "Test 4", description: "Descrizione 4"),
  ]
  static var previews: some View {
    Group {
      OnboardingView(style: .skip {}, items: OnboardingView_Previews.mocks)

      OnboardingView(
        style: .registerLogin(register: {}, login: {}),
        items: OnboardingView_Previews.mocks
      )
    }
  }
}
*/
