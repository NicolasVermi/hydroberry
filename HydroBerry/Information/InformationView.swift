//
//  InformationView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 10/01/21.
//

import SwiftUI

struct InformationView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: InformationViewModel

    @State var selectedPlant: String
    
    var body: some View {
            VStack(alignment:.leading){
                ZStack{
                    HStack{
                        Spacer()
                        Text("Informazioni")
                            .font(Font.system(size:17, weight: .semibold))
                        Spacer()
                    }.padding(.vertical)
                    
                    HStack{
                        Spacer()
                        ZStack{
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 237/255, green: 237/255, blue: 237/255))
                            Image(systemName: "plus")
                                .rotationEffect(.init(degrees: 45))
                                .foregroundColor(.gray)
                                
                    }.padding(.trailing, 16)
                    }.onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.padding(.top,10)
                
                Text(selectedPlant)
                .font(Font.system(size:28, weight: .bold))
                .padding(.vertical, 20)
                .padding(.leading,10)
                
                InformationCardView(leftString: "Nome:", rightString: viewModel.nomeScientifico)
                InformationCardView(leftString: "Temperatura:", rightString: String(viewModel.temperaturaMinima) + "-" + String(viewModel.temperaturaMassima) + " °C")
            InformationCardView(leftString: "Umidità:", rightString: String(viewModel.umiditaMinima) + "-" + String(viewModel.umiditaMassima) + " %")
            InformationCardView(leftString: "PH:", rightString: String(viewModel.phMinimo) + "-" + String(viewModel.phMassimo))
            InformationCardView(leftString: "EC:", rightString: String(viewModel.ecMinimo) + "-" + String(viewModel.ecMassimo) + " mS/cm")
            InformationCardView(leftString: "Tempo Crescita:", rightString: String(viewModel.tempoCrescitaMinimo) + "-" + String(viewModel.tempoCrescitaMassimo) + " giorni")
            InformationCardView(leftString: "Luce:", rightString: String(viewModel.oreLuce) + " ore" )
                Spacer()

            }.onAppear(perform: {viewModel.readData()})
    }
    
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(viewModel: InformationViewModel(nome: "Pomodoro"), selectedPlant: "Pomodoro")
    }
}
