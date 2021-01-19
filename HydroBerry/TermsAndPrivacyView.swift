//
//  TermsAndPrivacyView.swift
//  Mecha
//
//  Created by Mattia Valzelli on 09/09/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//


import DuckMaUI
import SwiftUI
import SafariServices


struct TermsAndPrivacyView: View {
  
    var body: some View {
        SafariButton()
    }
  let accept: () -> Void

    struct SafariButton: View {
        
        var body: some View {
            RootView().hosting()
        }
        
        struct RootView: View, Hostable {
            @EnvironmentObject private var hostedObject: HostingObject<Self>
            var address = "https://duckma.com/condizioni-generali-contratto-2020"
            var addressPrivacy = "https://duckma.com/privacy-policy"
            @State private var showLogin = false
            func present(address: String) { // UIKit code
                let safari = SFSafariViewController(url: URL(string: address)!)
                hostedObject.viewController?.present(safari, animated: true)
            }
            private var firstBlock: some View {
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
            }
            
            private var secondBlock: some View{
                VStack {
                    
                    Button(action: { present(address: address) }) { //prima aveva self.showTerms
                    TermPrivacyRowView(title: "Leggi termini e condizioni")
                      .foregroundColor(Color(ColorTheme.current.primary.dark))
                  }

                  Spacer().frame(height: 5)

                    Button(action: { present(address: addressPrivacy) }) { // prima aveva self.showPrivacyPolicy
                    TermPrivacyRowView(title: "Leggi privacy policy")
                      .foregroundColor(Color(ColorTheme.current.primary.dark))
                    }
                }
            }
            
          var body: some View {
            if showLogin{
                LoginView(viewModel: LoginViewModel(), showForgotPassword: {}, showRegistration: {})
            }
            else{
                VStack(alignment: .leading) {
                  Group {
                    Spacer()
                    Image("Group")
                    Spacer().frame(height: 32)
                  }
                    firstBlock
                  Spacer().frame(height: 24)
                    secondBlock
                  Spacer()
                    
                    Button(action: {showLogin = true}) {
                        UIViewPreview(horizontalHugging: .defaultLow) {
                          let button = FullButton()
                          button.setTitle("Accetta", for: .normal)
                          button.titleLabel?.font = FontTheme.current.semibold.subhead
                          button.cornerRadius = .medium
                          button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 0)
                          return button
                        }.padding(.vertical, 5)
                        .background(Color(red: 21/255, green: 132/255, blue: 103/255))
                      }.cornerRadius(5)
                   
                  Spacer()
                }
                .padding([.leading, .trailing], 32)
            }
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
}}
}

#if DEBUG
  struct TermsAndPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndPrivacyView(accept: {})
    }
  }
#endif

