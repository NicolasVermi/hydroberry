//
//  HomeView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//



import SwiftUI

struct HomeView: View {
    @State private var viewChoice = 0
    init() {
        
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {

                    
                    TabView {
                        bodyView
                            .tabItem {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }

                        GrowthView()
                            .tabItem {
                                Image(systemName: "leaf")
                                Text("Choose system")
                            }

                        Text("ProfileView()")
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("Profile")
                            }
                    }
                    //non penso servirà quando avrò le icone
                    .accentColor(Color(red: 21/255, green: 132/255, blue: 103/255))
                }
            
            }
        }
    }
    private var titleView: some View {
        VStack {
            HStack{
                Text("HOME").multilineTextAlignment(.leading)
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
        }.padding(.top,-50)
    }
        
    
    private var bodyView: some View {
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
                        Spacer()
                        ScrollView {
                            Spacer()
                            griglia
                    }
                }
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
        .padding(.top, 60)
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

struct home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

