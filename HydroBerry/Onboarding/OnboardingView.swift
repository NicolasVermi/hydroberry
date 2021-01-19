//
//  OnboardingView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//


import DuckMaUI
import SwiftUI


struct OnboardingView: View {
  let style: OnboardingStyle
  let items: [OnboardingItem]
  @State private var showPrivacy = false

  private func pageView(
    title: String,
    description: String,
    image: Image?
  ) -> some View {
    VStack(alignment: .leading) {
      Spacer().frame(height: 60)

      if image != nil {
        image!
            //.resizable()
            .frame(maxWidth: 228, maxHeight: 252)
          .padding([.leading, .trailing], 60)
      } else {
        RoundedRectangle(cornerRadius: 8)
          .foregroundColor(Color(ColorTheme.current.primary.dark))
          .aspectRatio(3 / 2, contentMode: .fit)
          .padding([.leading, .trailing], 25)
      }

      Spacer().frame(height: 50)

      Text(title)
        .fixedSize(horizontal: false, vertical: true)
        .font(Font.system(size:22, weight: .bold))
        .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
        .padding([.leading, .trailing], 32)
        .padding(.top, 40)

      Spacer().frame(height: 15)

      Text(description)
        .fixedSize(horizontal: false, vertical: true)
        .font(Font.system(size:16, weight: .regular))
        .foregroundColor(Color(red:130/255, green: 136/255, blue:148/255))
        .padding([.leading, .trailing], 32)

    }
  }

  private func skipButton(_ action: @escaping () -> Void) -> some View {
    Button(action: {showPrivacy = true}){
      UIViewPreview(horizontalHugging: .defaultLow) {
        let button = FullButton()
        button.setTitle("Salta", for: .normal)
        button.titleLabel?.font = FontTheme.current.semibold.subhead
        button.cornerRadius = .medium
        button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 0)
        
        return button
      }
      .padding(.vertical, 5)
      .background(Color(red: 21/255, green: 132/255, blue: 103/255))
    }.cornerRadius(5)
    .padding([.leading, .trailing], 32)
  }


  var body: some View {
    if showPrivacy {
        TermsAndPrivacyView(accept: {})
    }else{
        VStack {
          if !self.items.isEmpty {
            PagerView(
              self.items.map { item in
                self.pageView(title: item.title, description: item.description, image: item.image)
              }
            )
          }
          self.style.skipAction.map(self.skipButton(_:))
            .padding(.vertical, 40)
          
          Spacer().frame(height: 24)
        }
        
    }
    
    }
}


struct OnboardingView_Previews: PreviewProvider {
  static let mocks = [
    OnboardingItem(title: "Inserisci la tua pianta", description: "Crea una nuova coltivazione in pochi semplici passi e inserisci tutti i dati della cella idroponica utilizzata", image: Image("img_step1")),
    OnboardingItem(title: "Monitora i valori della cella idroponica", description: "Tieni sotto controllo i valori di temperatura, umidità, ph e conducibilità elettrica (EC) relativi alla cella idroponica", image: Image("img_step2")),
    OnboardingItem(title: "Monitora i progressi", description: "Controlla la crescita della pianta nel tempo, mostrando quanti giorni sono passati dalla sua nascita e quanto manca al raccoglimento dei suoi frutti.", image: Image("img_step3")),
  ]
  static var previews: some View {
      OnboardingView(style: .skip {}, items: OnboardingView_Previews.mocks)
    }
  }


