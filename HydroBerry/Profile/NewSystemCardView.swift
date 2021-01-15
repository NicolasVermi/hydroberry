//
//  NewSystemCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 13/01/21.
//

import SwiftUI

struct NewSystemCardView: View {
    var body: some View {
        Rectangle()
            .frame(minWidth: 150, idealWidth: 150, maxWidth: 150, minHeight: 60, idealHeight: 80, maxHeight: 180, alignment: .center)
            .cornerRadius(28)
            .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
            .overlay(
                VStack{
                    Image(systemName: "plus")
                        
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.white)
                    
                    Text("Aggiungi")
                        .font(Font.system(size:15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 30)
                }
            )
            .padding(5)
            .padding(.vertical,5)
    }
}

struct NewSystemCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewSystemCardView()
    }
}
