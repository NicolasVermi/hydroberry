//
//  SplashScreenView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 08/01/21.
//

import SwiftUI
import Combine

struct SplashScreenView: View {
    @State var showLogin = false
    @State private var hasTimeElapsed = false
    
    var body: some View {
        if showLogin{
            LoginView(
              viewModel: LoginViewModel(),
              showForgotPassword: {},
              showRegistration: {})
            
            //provaView()
            //OnboardingView(style: .skip {}, items: OnboardingView_Previews.mocks)
        }else{
            VStack{
                Spacer()
            HStack{
                Spacer()
                Image("logoLight")
                    .onAppear(perform: delayText)
                Spacer()
            }
                Spacer()
            }
            .background(Color(red: 81/255, green: 191/255, blue: 183/255))
            .edgesIgnoringSafeArea(.all)}

    }
    
    
    private func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            hasTimeElapsed = true
            showLogin = true
        }
      }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
