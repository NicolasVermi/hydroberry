//
//  AddCropStep2View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 12/01/21.
//

import SwiftUI
import DuckMaUI

struct AddCropStep2View: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showingStep1 = false
    @State var showingStep3 = false
    @State var selected1:Bool = false
    @State var selected2:Bool = false
    @State var selected3:Bool = false
    @State var systemName: String = ""
    
    var nameField: some View {
        CustomTextField(verticalHugging: .defaultHigh, horizontalHugging: .defaultLow, text: $systemName) {
        let textField = DuckTextField()
        textField.placeholder = "Inserisci nome"
        textField.backgroundStyle = .color(ColorTheme.current.gray.p20)
        textField.cornerRadius = .large
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        return textField
      }
    }
    
    var body: some View {
        if showingStep3{
            AddCropStep3View()
        }
        else{
            if showingStep1{AddCropStep1View()
                
            } else {
                VStack{
                titleBar
                    Text("step 2")
                        .font(Font.system(size:12, weight: .regular))
                        .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
                        .padding(10)
                    HStack{
                        Text("Inserisci il nome della cella idroponica")
                            .font(Font.system(size:28, weight: .bold))
                            .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                            .padding(.horizontal,16)
                            .padding(.vertical)
                        Spacer()
                    }
                    Spacer()
                    nameField.padding()
                    plantList
                    Spacer()
                }
            }
        }
    }

    
    private var titleBar: some View{
        HStack{
            Button(action: { self.showingStep1.toggle() }) {
            Image(systemName: "chevron.left").foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                .contentShape(Rectangle())
                .padding(.horizontal, 20).padding(.trailing, 10)
            }
            Spacer()
            
            Text("Aggiungi raccolto")
                .font(Font.system(size:17, weight: .semibold))
                .multilineTextAlignment(.center)

            Spacer()
            Button(action: {
                self.showingStep3.toggle();
            }) {
            Text("Fine")
                .padding(17)
                .font(Font.system(size:17, weight: .semibold))
                .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
            }
        }
    }
    

    
    private var plantList:some View{

        VStack{
            HStack{
                Text("Livello di Crescita")
                    .font(Font.system(size:17, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                    .padding()
                Spacer()
            }
            
            if selected1{
                GrowStepCardView(stepName: "Seme", stepImageName: "ic_semi_bianchi", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255))
                .onTapGesture(perform: {
                selected1 = false
            }
                )
                
            }else{
                GrowStepCardView(stepName: "Seme", stepImageName: "ic_semi_verde", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = true
                    selected2 = false
                    selected3 = false
                    
                }
                )
                
            }
            
            if selected2{
                GrowStepCardView(stepName: "Dai 15 ai 20 giorni", stepImageName: "ic_foglia_bianca", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255)).onTapGesture(perform: {
                selected2 = false
            })}else{
                GrowStepCardView(stepName: "Dai 15 ai 20 giorni", stepImageName: "ic_foglia_verde", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = false
                    selected2 = true
                    selected3 = false
                    
                }
                )
                
            }

            
            if selected3{
                GrowStepCardView(stepName: "Dai 20 ai 30 giorni", stepImageName: "ic_albero_bianco", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255)).onTapGesture(perform: {
                selected3 = false
            })}else{
                GrowStepCardView(stepName: "Dai 20 ai 30 giorni", stepImageName: "ic_albero_verde", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = false
                    selected2 = false
                    selected3 = true
                    
                })}
            

        }
    }
    
}


struct AddCropStep2View_Previews: PreviewProvider {
    static var previews: some View {
        AddCropStep2View()
    }
}
