//
//  GrowthView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 09/01/21.
//

import SwiftUI

struct GrowthView: View {
    @State private var progress: CGFloat = 50.0
    var body: some View {
        VStack{
            
            titleView.padding(.top,50)
            descriptionView
            imageView.padding(.bottom, 80)
            Spacer()
            
        }.navigationBarHidden(true)
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
        VStack
        {
            Rectangle()
                .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                .cornerRadius(10)
                .frame(height:51)
                .overlay(
                    HStack{
                        Text("Tipologia Pianta")
                            .font(Font.system(size:15, weight: .regular))
                            .padding(17)
                        Spacer()
                        Text("Pomodoro")
                            .font(Font.system(size:15, weight: .semibold))
                            .padding(17)
                    }
                ).padding(.horizontal, 10)
                .padding(.top,30)
            Rectangle()
                .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                .cornerRadius(10)
                .frame(height:51)
                .overlay(
                    HStack{
                        Text("Raccolta")
                            .font(Font.system(size:15, weight: .regular))
                            .padding(17)
                        Spacer()
                        Text("50-90 giorni")
                            .font(Font.system(size:15, weight: .semibold))
                            .padding(17)
                    }
                ).padding(.horizontal, 10)
        }
    }
    private var imageView: some View{
        VStack{
        HStack {
            Text("0%")
            Slider(value: $progress)
            Text("100%")
        }.padding()
        Image("ic_foglia")
            .resizable()
            .frame(width: 40, height: 40)
            .padding(.bottom, -5)
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
                            //.opacity(0.1)
                        
                       Circle()
                        .trim(from: 0, to: 0.75 * progress)
                        .stroke(Color(red: 11/255, green: 132/255, blue: 103/255), style: StrokeStyle(
                                    lineWidth: 30,
                                    lineCap: .round,
                                    lineJoin:.round))
                        
                            .rotationEffect(.degrees(135))
                        .overlay(
                            VStack{
                                Text("\(Int(progress*100))")
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
        GrowthView()
    }
}
