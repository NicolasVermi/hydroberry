//
//  InformationView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 10/01/21.
//

import SwiftUI

struct InformationView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            VStack(alignment:.leading){
                ZStack{
                    HStack{
                        Spacer()
                        Text("Informazioni")
                            .font(Font.system(size:17, weight: .semibold))
                            
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        ZStack{
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 237/255, green: 237/255, blue: 237/255))
                            Text("X")
                                .foregroundColor(.gray)
                                .font(Font.system(size:16, weight: .semibold))
                                
                    }.padding(.trailing, 16)
                    }.onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }.padding(.top,10)
            Text("Pomodoro")
                .font(Font.system(size:28, weight: .bold))
                .padding(.vertical, 20)
                .padding(.leading,10)
                
                InformationCardView(leftString: "Nome:", rightString: "Lycopersicon esculentum")
            InformationCardView(leftString: "Temperatura:", rightString: "22-25 °C")
            InformationCardView(leftString: "Umidità:", rightString: "60-80 %")
            InformationCardView(leftString: "PH:", rightString: "5,5-6,5")
            InformationCardView(leftString: "EC:", rightString: "2-3,5 mMhos")
            InformationCardView(leftString: "Tempo Crescita:", rightString: "50-80 giorni")
            InformationCardView(leftString: "Ore Luce:", rightString: "16-18 ore")
                Spacer()

            }
        }

}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
