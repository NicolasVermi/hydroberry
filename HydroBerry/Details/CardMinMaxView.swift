//
//  CardMinMaxView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//



import SwiftUI

struct CardMinMaxView: View {
    var generalLabel: String
    var measure: String
    var symbol: String
    var measureName: String
    var color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(Color.white)
            .frame(height:51)
            .overlay(
                        HStack {
                            Text(measureName + " " + generalLabel)
                                .font(Font.system(size:16))
                                .foregroundColor(.black)
                                
                            Spacer()
                            Text(measure)
                                .font(Font.system(size:16, weight: .semibold))
                                .foregroundColor(color)
                            Text(symbol)
                                .font(Font.system(size:16,weight: .semibold))
                                .foregroundColor(color)
                                .padding(.trailing, 10)
                            
                        }.padding(.horizontal, 5)
                        .padding(.leading, 5)
                        
)
    }
}


