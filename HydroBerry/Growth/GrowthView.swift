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
            titleView
            circleBarView
            Spacer()
        }
            
        

    }
    private var circleBarView: some View{
        VStack(spacing: 20){
                    HStack {
                        Text("0%")
                        Slider(value: $progress)
                        Text("100%")
                    }.padding()
                    Text("progress")
                    ZStack {

                        Circle()
                            .trim(from: 0, to: 0.75)
                            .stroke(Color.gray,style: StrokeStyle(
                                        lineWidth: 40,
                                        lineCap: .round,
                                        lineJoin:.round))
                            .rotationEffect(.degrees(135))
                            .opacity(0.1)
                        
                       Circle()
                        .trim(from: 0, to: 0.75 * progress)
                        .stroke(Color(red: 83/255, green: 132/255, blue: 103/255), style: StrokeStyle(
                                    lineWidth: 40,
                                    lineCap: .round,
                                    lineJoin:.round))
                        
                            .rotationEffect(.degrees(135))
                        .overlay(
                            Text("\(Int(progress * 100.0))%"))
                             
                    }.padding(20)
                    .frame(height: 300)
                    
                    Spacer()
                }
    }
    
    private var titleView: some View {
        VStack {
            HStack{
                Text("Crescita").multilineTextAlignment(.leading)
                    .font(Font.system(size:34, weight: .bold))
                Spacer()
            }.padding(.horizontal,5).padding(.bottom,8)
            
            HStack{
                Text("Sistema Ufficio").multilineTextAlignment(.leading)
                    .font(Font.system(size:17, weight: .bold))
                    .foregroundColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                Spacer()
            }.padding(.horizontal,5)
            
            Spacer()
        }
    }
}

struct GrowthView_Previews: PreviewProvider {
    static var previews: some View {
        GrowthView()
    }
}
