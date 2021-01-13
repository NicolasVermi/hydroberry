//
//  AddCropStep3View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 13/01/21.
//

import SwiftUI

struct AddCropStep3View: View {
    @Environment(\.presentationMode) var presentationMode
    @State var goHome:Bool = false
    @State var showingInfo = false
    
    var body: some View {
        
            VStack{
                titleBar
                Spacer()
                centralPart
                Spacer()
                bottomPart
                Spacer()
            }
        
        
        
    }
    
    private var titleBar: some View{
        HStack{
            Spacer()
            Text("Aggiungi raccolto")
                .font(Font.system(size:17, weight: .semibold))
            Spacer()
        }.padding()
    }
    
    private var centralPart: some View{
        VStack(alignment: .center){
            Image("ic_foglia").padding(30)
            Text("Il raccolto è stato inserito correttamente")
                .font(Font.system(size:28, weight: .bold))
                .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }
    
    private var bottomPart: some View{
        
        VStack{
            Button(action: { goHome = true }, label: {
                ZStack{
                Rectangle()
                    .frame(height: 58, alignment: .center)
                    .font(Font.system(size:15, weight: .semibold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                    .cornerRadius(4)
                    
                    Text("Torna alla home")
                           .foregroundColor(.white)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
          
                }
                
            }).padding(.horizontal, 32)
            Button(action: {
                self.showingInfo.toggle()
            }) {
                
                Text("Leggi informazioni della pianta")
                    .font(Font.system(size:17, weight: .regular))
                    .foregroundColor(Color(red: 1, green: 163/255, blue: 108/255))
                
                
            }.sheet(isPresented: $showingInfo) {
                InformationView()
            }
            
                
                .padding(32)
        }
        }
}

struct AddCropStep3View_Previews: PreviewProvider {
    static var previews: some View {
        AddCropStep3View()
    }
}
