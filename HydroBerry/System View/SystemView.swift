//
//  SystemView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 11/01/21.
//

import SwiftUI
import DuckMaUI

struct SystemView: View {
    @State var showingInfo = false
    @State var email = ""
    @State var showingAlert = false
    @State var selectedPlant: String
    @State var raccoltoID: String
    @StateObject var viewModel = SystemViewModel()

    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment:.leading){
            titleBar.frame(maxHeight:50)
            cropBar
            activeSystemBar
            Rectangle()
                .frame(height:16)
                .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
            authorizePart
                .padding(.vertical, 20)
            mailPart
            Spacer()
        }
        .onAppear(perform: {
            viewModel.readDataSystem(raccoltoID: raccoltoID)
        })
        .navigationBarHidden(true)
    }
    

    var emailView: some View {
        HStack{
          CustomTextField(verticalHugging: .defaultHigh, horizontalHugging: .defaultLow, text: $email) {
            let textField = DuckTextField()
            textField.placeholder = "Inserisci mail"
            textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
            textField.cornerRadius = .large
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.returnKeyType = .done
            return textField
          }
            Spacer()
            Button(action: {viewModel.addAuthorizedPeople(email: email);
                   viewModel.addListaRaccolti(idUtente: email)
                
            }) {
                UIViewPreview(horizontalHugging: .defaultHigh) {
                    let button = FullButton()
                    button.setTitle("Invia", for: .normal)
                button.titleLabel?.font = FontTheme.current.semibold.subhead
                    button.cornerRadius = .medium
                button.themeColor = .init(red: 1, green: 1, blue: 1, alpha: 0)
                return button
              }
                .padding(.vertical, 4)
                .padding(.horizontal, 15)
                .background(Color(red: 21/255, green: 132/255, blue: 103/255))
            }.cornerRadius(5)
        }
        
    }
 
    
    private var titleBar: some View{
        ZStack{
            Text("Ufficio")
                .font(Font.system(size:17, weight: .semibold))
                .multilineTextAlignment(.center)

            HStack{
                Spacer()
                Text("Elimina")
                    .font(Font.system(size:17, weight: .semibold))
                    .foregroundColor(.red)
                    .padding(.vertical)
                    .padding(.horizontal, 18)
                    .onTapGesture {
                        showingAlert = true
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Messaggio Importante"), message: Text("Sei sicuro di voler eliminare il sistema?"), primaryButton: .default(Text("Elimina"), action: { self.presentationMode.wrappedValue.dismiss(); viewModel.elimina(raccoltoID: raccoltoID)}), secondaryButton: .cancel())
                    }
            }
            Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                .contentShape(Rectangle())
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.leading,-175)
        }
        
    }
    
    private var cropBar: some View{
        Rectangle()
            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
            .cornerRadius(10)
            .frame(height:51)
            .overlay(
                HStack{
                    Text("Coltura:")
                        .font(Font.system(size:15, weight: .regular))
                        .padding(17)
                    Spacer()
                    Text(selectedPlant)
                        .font(Font.system(size:15, weight: .semibold))
                    Button(action: {
                        self.showingInfo.toggle()
                    }) {
                        
                        Image("ic_info").padding(.trailing, 17)
                        
                        
                    }.sheet(isPresented: $showingInfo) {
                        InformationView(viewModel: InformationViewModel(nome: selectedPlant), selectedPlant: selectedPlant)
                    }
                }
            ).padding(.horizontal, 15)
            .padding(.top, 30)
    }
    
    private var activeSystemBar: some View{
        Rectangle()
            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
            .cornerRadius(10)
            .frame(height:51)
            .overlay(
                HStack{
                    Text("Stato:")
                        .font(Font.system(size:15, weight: .regular))
                        .padding(17)
                    Spacer()
                    if viewModel.active{
                    Text("Raccolto attivo")
                        .font(Font.system(size:15, weight: .semibold))
                        .padding()
                        
                    }else{
                        Button(action: {viewModel.activeSystem(raccoltoID: raccoltoID)}) {
                        Text("Attiva")
                        .padding(.horizontal, 20)
                    }
                    }
                    }
                    
                
            ).padding(.horizontal, 15)
            .padding(.bottom, 10)
    }

    
    private var authorizePart: some View{
        VStack{
            Text("Autorizzazioni")
                .font(Font.system(size:17, weight: .semibold))
                .padding(.horizontal, 16)
            if viewModel.error == .missingEmail {
              Group {
                emailView
                  .border(Color.red, width: 1)
                    .padding(.vertical)
                    .padding(.horizontal)
                HStack {
                    Text("Email mancante o non nel formato corretto")
                        .padding(.horizontal)
                    .foregroundColor(Color(ColorTheme.current.danger.p100))
                  Spacer()
                }
              }
            } else if viewModel.error == .emailNotAvailable {
              emailView
                .border(Color.red, width: 1)
                .padding(.vertical)
                .padding(.horizontal)
                
              HStack {
                Text("Email già registrata")
                  .foregroundColor(Color(ColorTheme.current.danger.p100))
                Spacer()
              }
            } else if  viewModel.error == .notRegisteredAccount {
                 emailView
                    .border(Color.red, width: 1)
                    .padding(.vertical)
                    .padding(.horizontal)
                    
                  HStack {
                    Text("Account non registrato")
                      .foregroundColor(Color(ColorTheme.current.danger.p100))
                    Spacer()
                  }
            }else{
              emailView.padding(.vertical)
                .padding(.horizontal)
            }
            
 
        }
        
    }
    
    private var mailPart: some View{
        VStack{
            ScrollView{
                ForEach(viewModel.utentiAutorizzati, id: \.self) {
                    mail in
                    AuthCardView(raccoltoID: raccoltoID, mail: mail)
                }.onDelete
                { _ in print("eliminato") }
            }
            .padding(.bottom, 20)
        }
    }
    
}

struct SystemView_Previews: PreviewProvider {
    static var previews: some View {
        SystemView(selectedPlant: "Pomodoro", raccoltoID: "Ufficioesempio@gmail.com")
    }
}
