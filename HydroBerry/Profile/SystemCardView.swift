//
//  newSystemCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 13/01/21.
//

import SwiftUI

struct SystemCardView: View {
    
    var pianta: String
    var nomeSistema: String
    
    var body: some View {
        Rectangle()
            .frame(minWidth: 150, idealWidth: 150, maxWidth: 150, minHeight: 60, idealHeight: 80, maxHeight: 180, alignment: .center)
            .cornerRadius(28)
            .foregroundColor(.white)
            .shadow(radius: 10)
            .overlay(
                VStack(alignment:.leading){
                    Image(pianta)
                        
                        .resizable()
                        .frame(height: 100)
                        .padding(.horizontal,3)
                        .foregroundColor(.white)
                    
                    Text(nomeSistema)
                        .font(Font.system(size:15, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        
                    Text(pianta)
                        .font(Font.system(size:15, weight: .regular))
                        .foregroundColor(Color(red: 1, green: 163/255, blue: 108/255))
                        .padding(.horizontal)
                }
            )
            
            .padding(5)
            .padding(.vertical,5)
    }
}

struct SystemCardView_Previews: PreviewProvider {
    static var previews: some View {
        SystemCardView(pianta: "Pomodoro", nomeSistema: "Ufficio")
    }
}
