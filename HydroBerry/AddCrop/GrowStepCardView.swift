//
//  CropCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 11/01/21.
//

import SwiftUI

struct GrowStepCardView: View {
    var stepName:String
    var stepImageName:String
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
                    Image(stepImageName)
                        .resizable()
                        .frame(width:34,height: 44)
                        
                        .padding(16)
                    
                    Text(stepName)
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

struct GrowStepCardView_Previews: PreviewProvider {
    static var previews: some View {
        GrowStepCardView(stepName: "step1", stepImageName: "ic_semi_bianchi", stringColor: .white, rectColor: Color(red: 21/255, green: 132/255, blue: 103/255))
    }
}
