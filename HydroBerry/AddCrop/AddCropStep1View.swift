//
//  AddCropStep1View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 11/01/21.
//

import SwiftUI

struct AddCropStep1View: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selected1:Bool = false
    @State var selected2:Bool = false
    @State var selected3:Bool = false
    @State var selected4:Bool = false
    
    var body: some View {
        VStack{
            titleBar
            Text("step 1")
                .font(Font.system(size:12, weight: .regular))
                .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
                .padding(10)
            HStack{
                Text("Scegli la pianta")
                    .font(Font.system(size:28, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                    .padding(.horizontal,16)
                    .padding(.vertical)
                Spacer()
            }
            plantList
            Spacer()
        }
    }
    
    private var titleBar: some View{
        HStack{
            Text("Annulla")
                .padding(17)
                .foregroundColor(.red)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
            }
            Spacer()
            
            Text("Aggiungi raccolto")
                .font(Font.system(size:17, weight: .semibold))
                .multilineTextAlignment(.center)

            Spacer()
            
            Text("Avanti")
                .padding(17)
                .font(Font.system(size:17, weight: .semibold))
                .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
        }
    }
    
    
    private var plantList:some View{
        ScrollView {
            Spacer().frame(height:25)
        VStack{
            
            if selected1{
            CropCardView(plantName: "Pomodoro", plantImageName: "Pomodoro", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255))
                .onTapGesture(perform: {
                selected1 = false
            }
                )
                
            }else{
                CropCardView(plantName: "Pomodoro", plantImageName: "Pomodoro", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = true
                    selected2 = false
                    selected3 = false
                    selected4 = false
                }
                )
                
            }
            
            if selected2{
            CropCardView(plantName: "Insalata", plantImageName: "Insalata", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255)).onTapGesture(perform: {
                selected2 = false
            })}else{
                CropCardView(plantName: "Insalata", plantImageName: "Insalata", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = false
                    selected2 = true
                    selected3 = false
                    selected4 = false
                })}

            
            if selected3{
            CropCardView(plantName: "Soia", plantImageName: "Soia", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255)).onTapGesture(perform: {
                selected3 = false
            })}else{
                CropCardView(plantName: "Soia", plantImageName: "Soia", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = false
                    selected2 = false
                    selected3 = true
                    selected4 = false
                })}
            
            if selected4{
            CropCardView(plantName: "Peperoncino", plantImageName: "Peperoncino", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255)).onTapGesture(perform: {
                selected4 = false
            })}else{
                CropCardView(plantName: "Peperoncino", plantImageName: "Peperoncino", stringColor: .black, rectColor:.white).onTapGesture(perform: {
                    selected1 = false
                    selected2 = false
                    selected3 = false
                    selected4 = true
                })}
        }
    }
    
}
}

struct AddCropStep1View_Previews: PreviewProvider {
    static var previews: some View {
        AddCropStep1View()
    }
}
