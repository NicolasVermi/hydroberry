//
//  CropCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 11/01/21.
//

import SwiftUI

struct CropCardView: View {
    var plantName:String
    var plantImageName:String
    var stringColor: Color
    var rectColor: Color
    
    
    var body: some View {
        VStack{
        Rectangle()
            .frame(minHeight:60, idealHeight: 80, maxHeight: 100)
            .foregroundColor(rectColor)
            .cornerRadius(30)
            .shadow(color: Color(red: 217/255, green: 217/255, blue: 217/255), radius: 20)
            .overlay(
                
                HStack{
                    Image(plantImageName)
                        .resizable()
                        .frame(width:44,height: 44)
                        .cornerRadius(100)
                        .padding(16)
                    
                    Text(plantName)
                        .font(Font.system(size:17, weight: .semibold))
                        .foregroundColor(stringColor)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right").foregroundColor(stringColor)
                        .padding(24)
                }
                
            )
        }.padding(.horizontal, 16)
        .padding(.vertical,7)
        
    }
}

struct CropCardView_Previews: PreviewProvider {
    static var previews: some View {
        CropCardView(plantName: "Pomodoro", plantImageName: "Pomodoro", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255))
    }
}
