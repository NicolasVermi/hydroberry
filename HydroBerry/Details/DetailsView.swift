//
//  DetailsView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//

import SwiftUI

struct DetailsView: View {
    @State var pickerSelection = 0
    @State var titolo: String
    
    @Environment(\.presentationMode) var presentationMode


    var barValues: [[Int]] =
        //  [[1],[1],[1],[1]]
        [
            [22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23],
            [22,21,22,22,22,21,21],
            [22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23,22,21,22,22,22,21],
            [22,21,22,22,22,21,21,24,22],
        ]
    var titlesPart2: [String] = ["giornaliero", "settimanale", "mensile", "annuale"]
    var dimensions: [CGFloat] = [18,40,18,18]
    var axeXValues: [[String]] =
        [["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"],
         ["Lun","Mar","Mer","Gio","Ven","Sab","Dom"],
         ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"],
         ["1","2","3","4","5","6","7","8","9","10","11","12"]]
    
    public var axeXValuesHours: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"]
    
    @State var numero: Int = 0
    @State var dato: Int = 0
    
    var body: some View {    
                    VStack{
                        Text("").padding()
                        ZStack{
                            Text(titolo)
                                .font(Font.system(size:17, weight: .semibold))
                                .multilineTextAlignment(.center)
                            
  
                            Image(systemName: "chevron.left").foregroundColor(Color(red: 117/255, green: 117/255, blue: 117/255))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                .padding(.leading,-175)
                        }.frame(maxHeight:50)
                        
                        Spacer()
                    Picker(selection: $pickerSelection, label: Text("Stats")) {
                        Text("G").tag(0)
                        Text("S").tag(1)
                        Text("M").tag(2)
                        Text("A").tag(3)

                    }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
                    
                        graphicPart.padding(.bottom, 35).padding(.top, 25)

                    ZStack{
                        RoundedRectangle(cornerRadius: 37)
                            .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                            .frame(height:300)
        
                    VStack {
                        maxCard.padding(.horizontal,8).padding(.vertical, 5)
                        minCard.padding(.horizontal,8).padding(.vertical, 5)
                        recommendedValueCard.padding(.horizontal,8).padding(.vertical, 5)
                        Spacer()
                    }.padding(.top,33)
                    }
                    }

    }

    private var maxCard: some View {
        CardMinMaxView(generalLabel: "massima rilevata",measure: "24.9", symbol: "°C", measureName: "Temperatura", color: Color(red: 158/255, green: 51/255, blue: 26/255))
            .padding(-2.0)
            
    }

    private var minCard: some View {
        CardMinMaxView(generalLabel: "minima rilevata",measure: "21.9", symbol: "°C", measureName: "Temperatura", color: Color(red: 108/255, green: 223/255, blue: 239/255))
    }
    
    private var recommendedValueCard: some View {
        CardMinMaxView(generalLabel: "consigliata",measure: "22-25", symbol: "°C", measureName: "Temperatura", color: Color(red: 21/255, green: 132/255, blue: 103/255))
    }

    private var graphicPart: some View {
        VStack{
            Text("Andamento " + titlesPart2[pickerSelection])
                .font(.title3)
                .bold()
            ScrollView(.horizontal) {
                VStack(alignment:.leading){
                    HStack(alignment: .center) {

                        ForEach(barValues[pickerSelection], id: \.self) {
                            data in
                            VStack(alignment: .leading) {
                                BarView(value: CGFloat(data), cornerRadius: 20).frame(width:dimensions[pickerSelection])
                            }
                        }
                        
                    }
                    .animation(.default)
                    
                    HStack(alignment: .center) {
                        ForEach(axeXValues[pickerSelection], id: \.self) {
                            data in
                            Text(String(data))
                                .font(.footnote)
                                .lineLimit(nil)
                                .frame(width:dimensions[pickerSelection])
                        }
                        
                    }.animation(.default)
                }
            }
            .padding(.horizontal, 20)
        }
       /*
        private var graphicPart: some View {
            ScrollView(.horizontal) {
                HStack(alignment: .center, spacing: 10) {

                    ForEach(barValues[pickerSelection], id: \.self) {
                        data in
                        
                        VStack {
                            
                            BarView(value: CGFloat(data), cornerRadius: 20, etichetta: String(axeXValues[pickerSelection][2]))
                            
                            //BarView(value: CGFloat(data), cornerRadius: 20, etichetta: String(axeXValuesHours[3]))
                            
                        }
                    }
                }
                .padding(.top, 24).animation(.default)
            }
            .padding(.horizontal, 20)
        }
        */
    /*
    private var graphicPart: some View {
        ScrollView(.horizontal) {
                barraFunc(valori: barValues[pickerSelection],valori2: axeXValuesHours)
            }
            .padding(.top, 24)
        .animation(.default)
        
    }
        
        func barraFunc(valori: [Int], valori2: [String]) -> some View {
        var numero = 0
        for _ in Range(0...valori.count){

            numero = numero + 1
            altra(valori: valori, valori2: valori2, numero: numero)
        }
        return
    }
      */
        
        
        
    }
    /*
    struct altra: View {
        var valori: [Int]
        var valori2: [String]
        var numero: Int

        var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            Text("")
            BarView(value: CGFloat(valori[numero]), cornerRadius: 20, etichetta: String(valori[numero]))
        }
            
        }
    }*/

    struct BarView: View {
        var value: CGFloat
        var cornerRadius: CGFloat
        //var etichetta: String

        var body: some View {
            VStack {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 15, height: 200).foregroundColor(.white)
                    VStack{
                        Text(String(Int(value))).font(.footnote)

                        RoundedRectangle(cornerRadius: cornerRadius)
                            .frame(width: 15, height: value*5).foregroundColor(Color(red: 1, green: 163/255, blue: 108/255))
                        
                    }
                }.padding(.bottom, 8)
               // Text(etichetta)
            }
        }
        
    }
}



struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(titolo: "Temperatura")
    }
}
