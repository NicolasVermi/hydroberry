//
//  CardHomeView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//

import SwiftUI

struct CardHomeView: View {
    var image: String
    var mesure: String
    var symbol: String
    var namedLabel: String

    var body: some View {
        Button(action: {}) {
            ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white)
                .frame(minWidth: 20, idealWidth: 164, maxWidth: 180,
                       minHeight: 20, idealHeight: 217, maxHeight: 220)
                .shadow(radius: 20)
                
                    VStack {
                        NavigationLink(destination: SplashScreenView()) {
                            LazyHGrid(rows: [
                                GridItem(.flexible(maximum: 30)),
                                GridItem(.fixed(60)),
                                GridItem(.flexible(maximum: 20)),
                            ]
                            ) {
                                HStack {
                                    
                                    Image(image)
                                        .padding(.bottom, 16)
                                        .padding(.trailing, 80)
                                   // Spacer()
                                }
                                HStack{
                                    Text(namedLabel)
                                        .bold()
                                        .font(Font.system(size: 15))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }.padding(.bottom, 35)
                               
                                
                                    
                                HStack {
                                    VStack{
                                        Spacer()
                                    Text(mesure)
                                        .font(Font.system(size: 41, weight: .light))
                                        .foregroundColor(Color(red: 84/255, green: 85/255, blue: 89/255))
                                    Spacer()
                                    }
                                    VStack{
                                    Text(symbol)
                                        .font(Font.system(size: 15))        .bold()
                                        .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                                        Spacer()
                                    }
                                    Spacer()
                                }.padding(.vertical, 35)
                                
                            }
                        }
                    }
                
            }
                
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CardHomeView(image: "ph", mesure: "24.9", symbol: "St", namedLabel: "namedLabel")
    }
}
