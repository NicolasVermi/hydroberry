//
//  descriptionCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 23/01/21.
//

import SwiftUI

struct descriptionCardView: View {
    var titolo: String
    var descrizione: String
    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
            .cornerRadius(10)
            .frame(height:51)
            .overlay(
                HStack{
                    Text(titolo)
                        .font(Font.system(size:15, weight: .regular))
                        .padding(17)
                    Spacer()
                    Text(descrizione)
                        .font(Font.system(size:15, weight: .semibold))
                        .padding(17)
                }
            ).padding(.horizontal, 10)
            .padding(.top,30)
    }
}

struct descriptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        descriptionCardView(titolo: "titolo", descrizione: "descrizione")
    }
}
