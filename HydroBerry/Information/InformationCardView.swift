//
//  InformationCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 10/01/21.
//

import SwiftUI

struct InformationCardView: View {
    var leftString: String
    var rightString: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
            .cornerRadius(10)
            .frame(height:51)
            .overlay(
                HStack{
                    Text(leftString)
                        .font(Font.system(size:15, weight: .regular))
                        .padding(17)
                    Spacer()
                    Text(rightString)
                        .font(Font.system(size:15, weight: .semibold))
                        .padding(17)
                }
            ).padding(.horizontal, 10)
            .padding(.vertical,5)
            
    }
}

struct InformationCardView_Previews: PreviewProvider {
    static var previews: some View {
        InformationCardView(leftString: "Nome", rightString: "Pomodoro")
    }
}
