//
//  HomeView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//



import SwiftUI

struct HomeView: View {
    @State private var selection = 0
    
    init() {
        
       UITabBar.appearance().barTintColor = UIColor.white
       UITabBar.appearance().shadowImage = UIImage()
       UITabBar.appearance().backgroundImage = UIImage()
    }
    
    var body: some View {
            ZStack {
                VStack {

                    TabView(selection: $selection) {
                        bodyView
                            .tabItem {
                                if selection == 0 {
                                    Image("ic_home_active")
                                } else {
                                    Image("ic_home")
                                }
                                Text("Home")
                            }.tag(0)

                        GrowthView()
                            .tabItem {
                                if selection == 1 {
                                    Image("ic_leaf_active")
                                } else {
                                    Image("ic_leaf")
                                }
                                Text("Crescita")
                            }.tag(1)

                        ProfileView(showTerms: {}, showPrivacyPolicy: {})
                            .tabItem {
                                if selection == 2 {
                                    Image("ic_profilo_active")
                                } else {
                                    Image("ic_profilo")
                                }
                                Text("Profilo")
                            }.tag(2)
                    }
                    .accentColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                }.navigationBarHidden(true)
            }.navigationBarHidden(true)
    }
    
    private var bodyView: some View {
        VStack{
            Spacer()
        ZStack{
            HStack{
                Spacer()
                VStack{
                Image("Pomodoro")
                    .resizable()
                    .frame(width:345, height: 345)
                    .padding(.top,-100)
                Spacer()
                }
                }
            HStack{
                titleView.padding()
            }
                    VStack {
                        //Spacer()
                        //ScrollView {
                            //Spacer()
                            griglia
                        //}.frame()
                }
        }
        }.navigationBarHidden(true)
        
    }
    
    
    private var titleView: some View {
        VStack {
            HStack{
                Text("Home").multilineTextAlignment(.leading)
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
    
    private var griglia: some View {
        LazyVGrid(columns:
            [GridItem(.flexible(minimum: 40, maximum: 400)), GridItem(.flexible(minimum: 40, maximum: 400))]) {
            temperatureCard.padding(7)
            humidityCard.padding(7)
            pHCard.padding(7)
            eCCard.padding(7)
        }.padding(16)
        .padding(.top, 120)
    }

    private var temperatureCard: some View {
        CardHomeView(image: "temperature", mesure: "29.9", symbol: "°C", namedLabel: "Temperatura")
    }

    private var humidityCard: some View {
        CardHomeView(image: "umidita", mesure: "49.9", symbol: "%", namedLabel: "Umidità")
    }

    private var pHCard: some View {
        CardHomeView(image: "ph", mesure: "4.6", symbol: "pH", namedLabel: "pH")
    }

    private var eCCard: some View {
        CardHomeView(image: "EC", mesure: "1.3", symbol: "mS/cm", namedLabel: "EC")
    }

    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

