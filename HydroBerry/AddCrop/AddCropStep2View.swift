//
//  AddCropStep2View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 12/01/21.
//

import SwiftUI

struct AddCropStep2View: View {
    @Environment(\.presentationMode) var presentationMode

    @State var selected1:Bool = false
    @State var selected2:Bool = false
    @State var selected3:Bool = false
    
    
    
    
    var body: some View {
        VStack{
        titleBar
            Spacer()
        plantList
        }
    }
    
    
    private var titleBar: some View{
        HStack{
            Image(systemName: "chevron.left").foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                .contentShape(Rectangle())
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }.padding(.horizontal,15)
            Spacer()
            
            Text("Aggiungi raccolto")
                .font(Font.system(size:17, weight: .semibold))
                .multilineTextAlignment(.center)

            Spacer()
            
            Text("Fine")
                .padding(17)
                .font(Font.system(size:17, weight: .semibold))
                .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
        }
    }
    
    
    
    private var plantList:some View{

        VStack{
            
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
                    
                })}

            
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
