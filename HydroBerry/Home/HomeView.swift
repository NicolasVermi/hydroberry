//
//  HomeView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//



import SwiftUI

struct HomeView: View {
    @State private var selection = 0
    @ObservedObject var viewModel: HomeViewModel

    
    init() {
        
       UITabBar.appearance().barTintColor = UIColor.white
       UITabBar.appearance().shadowImage = UIImage()
       UITabBar.appearance().backgroundImage = UIImage()
        self.viewModel = HomeViewModel()
    }
    
    var body: some View {
            ZStack {
                VStack {
                    TabView(selection: $selection) {
                        bodyView.onAppear(perform: {
                            viewModel.readData()
                        })
                            .tabItem {
                                if selection == 0 {
                                    Image("ic_home_active")
                                } else {
                                    Image("ic_home")
                                }
                                Text("Home")
                            }.tag(0)

                        GrowthConteinerView()
                            .tabItem {
                                if selection == 1 {
                                    Image("ic_leaf_active")
                                } else {
                                    Image("ic_leaf")
                                }
                                Text("Crescita")
                            }.tag(1)

                        ProfileView()
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
                            griglia
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
        CardHomeView(image: "temperature", mesure: String(viewModel.temperatura), symbol: "°C", namedLabel: "Temperatura")
    }

    private var humidityCard: some View {
        CardHomeView(image: "umidita", mesure: String(viewModel.umidita), symbol: "%", namedLabel: "Umidità")
    }

    private var pHCard: some View {
        CardHomeView(image: "ph", mesure: String(viewModel.ph), symbol: "pH", namedLabel: "pH")
    }

    private var eCCard: some View {
        CardHomeView(image: "EC", mesure: String(viewModel.ec), symbol: "mS/cm", namedLabel: "EC")
    }

    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

