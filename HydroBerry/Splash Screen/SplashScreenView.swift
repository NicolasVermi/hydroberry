//
//  SplashScreenView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack{
            Spacer()
        HStack{
            Spacer()
            Image("logoLight")
            Spacer()
        }
            Spacer()
        }
        .background(Color(red: 81/255, green: 191/255, blue: 183/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
