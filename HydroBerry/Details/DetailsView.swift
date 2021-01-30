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
    @State var numero: Double = 0.0
    
    @Environment(\.presentationMode) var presentationMode
    
    var barValues: [[Int]] =
        [
            [22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23],
            [22,21,22,22,22,21,21],
            [22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23,22,21,22,22,22,21,21,23,22,21,22,22,22,21],
            [22,21,22,22,22,21,21,24,22],
        ]
    
    var titlesPart2: [String] = ["giornaliero", "settimanale", "mensile", "annuale"]
    
    var dimensions: [CGFloat] = [18,40,18,18]
    var generalLableMax: [String] = ["massima rilevata", "massimo rilevato"]
    var generalLableMin: [String] = ["minima rilevata", "minimo rilevato"]
    var generalLableCons: [String] = ["consigliata", "consigliato"]
    
    var axeXValues: [[String]] =
        [["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"],
         ["Lun","Mar","Mer","Gio","Ven","Sab","Dom"],
         ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"],
         ["1","2","3","4","5","6","7","8","9","10","11","12"]]
    
    
   
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
                    }.onAppear(perform: {
                        choseNumero(misura: titolo)
                    })

    }
    
    func choseGeneralLable(misura: String) -> [String] {
        var lable: [String] = ["","",""]
        if misura == "pH"{
            lable[0] = generalLableMax[1]
            lable[1] = generalLableMin[1]
            lable[2] = generalLableCons[1]
        }else{
            lable[0] = generalLableMax[0]
            lable[1] = generalLableMin[0]
            lable[2] = generalLableCons[0]
        }
        return lable
    }
    
    func choseSymbol(misura: String) -> String {
        var lable: String = ""
        switch misura {

        case "Temperatura":
           lable = " °C"

        case "Umidità":
           lable = " %"
            
        case "pH":
           lable = " pH"
        
        case "EC":
           lable = " mS/cm"

        default:
           lable = ""
        }

        return lable
    }
    
    func choseNumero(misura: String){
        var lable: String = ""
        switch misura {

        case "Temperatura":
           numero = 1

        case "Umidità":
           numero = 3
            
        case "pH":
            numero = 0.22
        
        case "EC":
            numero = 0.11

        default:
           numero = 1
        }

    }
    

    private var maxCard: some View {
        CardMinMaxView(generalLabel: choseGeneralLable(misura: titolo)[0],measure: "24.9", symbol: choseSymbol(misura: titolo), measureName: titolo, color: Color(red: 158/255, green: 51/255, blue: 26/255))
            .padding(-2.0)
            
    }

    private var minCard: some View {
        CardMinMaxView(generalLabel: choseGeneralLable(misura: titolo)[1],measure: "21.9", symbol: choseSymbol(misura: titolo), measureName: titolo, color: Color(red: 108/255, green: 223/255, blue: 239/255))
    }
    
    private var recommendedValueCard: some View {
        CardMinMaxView(generalLabel: choseGeneralLable(misura: titolo)[2],measure: "22-25", symbol: choseSymbol(misura: titolo), measureName: titolo, color: Color(red: 21/255, green: 132/255, blue: 103/255))
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
                                BarView(value: CGFloat(data), cornerRadius: 20, etichetta:( CGFloat(data) * CGFloat(numero))).frame(width:dimensions[pickerSelection])
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
    }


    struct BarView: View {
        var value: CGFloat
        var cornerRadius: CGFloat
        
        var etichetta: CGFloat

        var body: some View {
            VStack {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 15, height: 200).foregroundColor(.white)
                    VStack{
                        Text(String(Int(etichetta ))).font(.footnote)

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
