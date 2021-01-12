//
//  SystemView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 11/01/21.
//

import SwiftUI

struct SystemView: View {
    @State var showingInfo = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment:.leading){
                        titleBar.frame(maxHeight:50)
                        cropBar
                        Rectangle()
                            .frame(height:16)
                            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                        authorizePart
                            .padding(.vertical, 20)
                        mailPart
                        Spacer()
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
                    Text("Pomodoro")
                        .font(Font.system(size:15, weight: .semibold))
                    Button(action: {
                        self.showingInfo.toggle()
                    }) {
                        
                        Image("ic_info").padding(.trailing, 17)
                        
                        
                    }.sheet(isPresented: $showingInfo) {
                        InformationView()
                    }
                    
                }
            ).padding(.horizontal, 15)
            .padding(.vertical, 30)
    }
    
    
    
    
    private var authorizePart: some View{
        VStack{
            Text("Autorizzazioni")
                .font(Font.system(size:17, weight: .semibold))
                .padding(.horizontal, 16)
            HStack{
                Text("Textfield DuckmaUI")
                Spacer()
                Text("Button DuckmaUI")
            }.padding(.vertical)
            .padding(.horizontal)
        }
        
    }
    
    private var mailPart: some View{
        VStack{
            AuthCardView(mail: "mariorossi@gmail.com")
            AuthCardView(mail: "paolorossi@gmail.com")
            AuthCardView(mail: "mariorosa@gmail.com")
            AuthCardView(mail: "mariannarossi@gmail.com")
        }
    }
    
}

struct SystemView_Previews: PreviewProvider {
    static var previews: some View {
        SystemView()
    }
}
