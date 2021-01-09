//
//  DetailsView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//

import SwiftUI

struct DetailsView: View {
    @State var pickerSelection = 0

    var barValues: [[CGFloat]] =
        //  [[1],[1],[1],[1]]
        [
            [10, 20, 50, 100, 120, 90, 180, 10, 20, 50, 100, 120, 90, 180, 10, 20, 50, 100, 120, 90, 180, 20, 30, 40],
            [10, 20, 50, 100, 120, 90, 180],
            [200, 110, 30, 170, 50, 100, 100, 100, 200, 80, 90, 50, 100, 100, 100, 200, 80, 90, 50, 100, 100, 100, 200, 80, 90, 0, 0, 0, 0, 0],
            [5, 150, 50, 100, 200, 110, 30, 170, 50, 0, 0, 0],
            
            
            
        ]
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Text("Dettaglio")
                    Spacer()
                }
                
                Spacer()
                ScrollView {
                    VStack{
                    Picker(selection: $pickerSelection, label: Text("Stats")) {
                        Text("G").tag(0)
                        Text("S").tag(1)
                        Text("M").tag(2)
                        Text("A").tag(3)

                    }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10).padding(.top, 40)
                        graphicPart.padding(.bottom, 35).padding(.top, 25)
                    Spacer()
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 37)
                            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                            .frame(height:800)
                            
                    VStack {
                        
                        maxCard.padding(.horizontal,8).padding(.vertical, 5)
                        minCard.padding(.horizontal,8).padding(.vertical, 5)
                        recommendedValueCard.padding(.horizontal,8).padding(.vertical, 5)
                        Spacer()
                    }.padding(.top,33)
                        
                    }
                        
                    }
                    
                }
            }
        }
    }

    private var maxCard: some View {
        CardMinMaxView(generalLabel: "massima rilevata",measure: "29.9", symbol: "°C", measureName: "Temperatura", color: Color(red: 158/255, green: 51/255, blue: 26/255))
            .padding(-2.0)
            
    }

    private var minCard: some View {
        CardMinMaxView(generalLabel: "minima rilevata",measure: "19.9", symbol: "°C", measureName: "Temperatura", color: Color(red: 108/255, green: 223/255, blue: 239/255))
    }
    
    private var recommendedValueCard: some View {
        CardMinMaxView(generalLabel: "consigliata",measure: "22.9", symbol: "°C", measureName: "Temperatura", color: Color(red: 21/255, green: 132/255, blue: 103/255))
    }
    private var graphicPart: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ForEach(barValues[pickerSelection], id: \.self) {
                    data in

                    VStack {
                        BarView(value: data, cornerRadius: 20)
                        Text(pickerSelection.description)
                    }
                }
            }

            .padding(.top, 24).animation(.default)
        }

        .padding(.horizontal, 20)
    }
    
}
struct BarView: View {
    var value: CGFloat
    var cornerRadius: CGFloat

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 15, height: 200).foregroundColor(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 15, height: value).foregroundColor(Color(red: 1, green: 163/255, blue: 108/255))

            }.padding(.bottom, 8)
        }
    }
}
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
