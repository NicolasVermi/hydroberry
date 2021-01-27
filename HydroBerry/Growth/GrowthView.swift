//
//  GrowthView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 09/01/21.
//

import SwiftUI

struct GrowthConteinerView: View {
    @StateObject var viewModel = GrowthViewModel()

    var body: some View {
        GrowthView(
            viewModel: viewModel,
            percCompletamento: viewModel.percCompletamento,
            isLoading: viewModel.isLoading
        )
//            .onAppear { viewModel.readData() }
    }
}

struct GrowthView: View {
    
    @ObservedObject var viewModel: GrowthViewModel
    @State var giorniPassati: CGFloat = 0.75
    @State var giorniTotali: CGFloat = 100
    @State var giorniRaccolta:String = "0"
    @State var percCompletamento: CGFloat
    @State var isLoading: Bool

    var body: some View {
        
        VStack{
            titleView
                .padding(.top,50)
            descriptionView
            imageView
                .padding(.bottom, 80)
            Spacer()
        }.navigationBarHidden(true)
        .onAppear(perform: {
            viewModel.readData()
        })
        .onReceive(viewModel.$percCompletamento) { newPerc in
            percCompletamento = CGFloat(newPerc)
        }
        
        
    }

    private var titleView: some View {
        VStack {
            HStack{
                Text("Crescita").multilineTextAlignment(.leading)
                    .font(Font.system(size:34, weight: .bold))
                Spacer()
            }.padding(.horizontal,10).padding(.bottom,8)
            
            HStack{
                Text("Sistema Ufficio").multilineTextAlignment(.leading)
                    .font(Font.system(size:17, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                Spacer()
            }.padding(.horizontal,10)
        }
    }
    
    
    private var descriptionView: some View{
        VStack{
            descriptionCardView(titolo: "Tipologia pianta", descrizione: viewModel.nomePianta)
            descriptionCardView(titolo: "Raccolta", descrizione: String(viewModel.tempoCrescitaMinimo) + "-" + String(viewModel.tempoCrescitaMassimo) + " giorni" )

        }
    }
    
    private var imageView: some View {
        VStack{
            if isLoading{
                VStack {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        .foregroundColor(.yellow)

                }.padding(.bottom, 100)
                
            } else {
            
                VStack{
                    Spacer()
                    Image("ic_foglia")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.bottom, -5)
                        .padding(.top, 10)
                    
                    HStack(alignment:.bottom )
                    {
                        Image("ic_semi")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, -100)
                        circleBarView
                        Image("ic_albero")
                            .resizable()
                            .frame(width: 32, height: 40)
                            .padding(.leading, -40)
                    }
                    Spacer()
                }
            }
        }
        
    }
    
    private var circleBarView: some View{
        VStack(spacing: 20){
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.75)
                            .stroke(Color(red: 229/255, green: 231/255, blue: 235/255),style: StrokeStyle(
                                        lineWidth: 30,
                                        lineCap: .round,
                                        lineJoin:.round))
                            .rotationEffect(.degrees(135))
                        
                       Circle()
                        .trim(from: 0, to: 0.0075 * percCompletamento)
                        .stroke(Color(red: 11/255, green: 132/255, blue: 103/255), style: StrokeStyle(
                                    lineWidth: 30,
                                    lineCap: .round,
                                    lineJoin:.round))
                            .rotationEffect(.degrees(135))
                        .overlay(
                            VStack{
                                Text("\(Int(viewModel.delta))")
                                    .font(Font.system(size:41, weight: .bold))
                                    .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
                                Text("Giorni dalla semina")
                                    .font(Font.system(size:13, weight: .bold))
                                    .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
                            }
                            )
                    }.padding(20)
                    .frame(width: 250,height: 250)
                }
    }
}


struct GrowthView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            GrowthView(viewModel: GrowthViewModel(), percCompletamento: 0.1, isLoading: true)
            
        }
    }
    
}
