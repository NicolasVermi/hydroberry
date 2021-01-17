//
//  ForgotPasswordStep1View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 14/01/21.
//

import SwiftUI
import DuckMaUI

struct ForgotPasswordStep2View: View {
    @State private var code = ""
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                HStack{
                    Image(systemName: "chevron.left").foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                        .contentShape(Rectangle())
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                    Spacer()
                }
                Text("Inserisci il codice che ti è stato inviato via mail")
                    .font(Font.system(size:34, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                    .padding(16)
                    .padding(.vertical, 40)
                
                inputFields
                Spacer()
                NavigationLink(destination: ForgotPasswordStep3View(viewModel: viewModel)){
                  UIViewPreview(horizontalHugging: .defaultLow) {
                    let button = FullButton()
                    button.setTitle("Avanti", for: .normal)
                    button.titleLabel?.font = FontTheme.current.semibold.subhead
                      button.themeColor = .init(red: 21/255, green: 132/255, blue: 103/255, alpha: 1)
                    button.cornerRadius = .medium
                    return button
                  }
                }.padding(16)
                Spacer()
            }.padding(16)
            .navigationBarHidden(true)
        }.navigationBarHidden(true)
    }
    
    var inputFields: some View {
      VStack {
        if viewModel.error == .missingEmail {
          VStack(alignment: .leading) {
            codeField
              .border(Color.red, width: 1)
            //ha sensooo????
            Text("codice mancante")
              .foregroundColor(Color(ColorTheme.current.danger.p100))
          }
        } else {
          codeField
        }

      }
    }
    
    var codeField: some View {
      CustomTextField(
        verticalHugging: .defaultHigh,
        horizontalHugging: .defaultLow,
        text: $code
      ) {
        let textField = DuckTextField()
        textField.placeholder = "Inserisci codice"
        textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
        textField.cornerRadius = .large
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
      }
    }
}

struct ForgotPasswordStep2View_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordStep2View(viewModel: LoginViewModel())
    }
}
