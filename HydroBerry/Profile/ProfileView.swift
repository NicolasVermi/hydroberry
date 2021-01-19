//
//  ProfileView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 13/01/21.
//

import SwiftUI
import DuckMaUI
import SafariServices
import FirebaseAnalytics
import FirebaseAuth

struct ProfileView: View {
    let showTerms: () -> Void
    let showPrivacyPolicy: () -> Void

    
    var body: some View {
        SafariButton()
    }
    
    struct SafariButton: View {
        var body: some View {
            RootView().hosting()
        }
        
        struct RootView: View, Hostable {
            
            @EnvironmentObject private var hostedObject: HostingObject<Self>

            var address = "https://duckma.com/condizioni-generali-contratto-2020"
            var addressPrivacy = "https://duckma.com/privacy-policy"
            @State var showingEditProfile = false
            @State var showingAddCrop = false
            @State var Name = "Mario Rossi"
            @State var showingAlert = false
            @State var showingLogin = false
            
            
            func present(address: String) { // UIKit code
                let safari = SFSafariViewController(url: URL(string: address)!)
                hostedObject.viewController?.present(safari, animated: true)
            }

            var body: some View {
                if showingLogin{LoginView(viewModel: LoginViewModel(), showForgotPassword: {}, showRegistration: {})
                }else{
                NavigationView{
                    VStack{
                        HStack{
                            Text("Profilo").multilineTextAlignment(.leading)
                                .font(Font.system(size:34, weight: .bold))
                            Spacer()
                        }
                        .padding(.bottom,20)
                        
                        systemPart
                        Spacer()
                        termsPart
                        Spacer()
                    }.padding()
                }.navigationBarHidden(true)
                }
                
            }
            
            public var systemPart: some View{
                VStack{
                    HStack{
                        Text(Name)
                            .font(Font.system(size:22, weight: .semibold))
                        Spacer()
                    }.padding(.bottom,10)
                    HStack{
                        Text("Sistemi:")
                        Spacer()
                    }
                    ScrollView(.horizontal){
                        HStack{
                            Button(action: {
                                self.showingAddCrop.toggle()
                            }) {
                                
                                NewSystemCardView()
                            }.sheet(isPresented: $showingAddCrop) {
                                AddCropStep1View()
                            }
                            NavigationLink(destination: SystemView()) {
                                SystemCardView()
                            }.navigationBarHidden(true)
                            SystemCardView()
                            SystemCardView()
                        }
                    }
                }
            }
            
            private var termsPart: some View{
                VStack {
                    
                    Button(action: {self.showingEditProfile.toggle()}) {
                      TermPrivacyRowView(title: "Modifica dati personali")
                        .foregroundColor(Color(ColorTheme.current.primary.dark))
                          
                    }.sheet(isPresented: $showingEditProfile) {
                        EditProfileView(lastName: Name, firstName: Name, email: Auth.auth().currentUser?.email ?? "nessuno")
                    }
                    
                    Spacer().frame(height: 5)

                    
                    Button(action: { present(address: address) }) { //prima aveva self.showTerms
                    TermPrivacyRowView(title: "Leggi termini e condizioni")
                      .foregroundColor(Color(ColorTheme.current.primary.dark))
                  }

                  Spacer().frame(height: 5)

                    Button(action: { present(address: addressPrivacy) }) { // prima aveva self.showPrivacyPolicy
                    TermPrivacyRowView(title: "Leggi privacy policy")
                      .foregroundColor(Color(ColorTheme.current.primary.dark))
                        
                  }
                    Button(action: {do {
                        try Auth.auth().signOut()
                        showingLogin = true
                        print("logout effettuato")
                      } catch {
                        print("Sign out error")
                      }}){
                    VStack(alignment: .leading) {
                      HStack {
                        Text("Logout")
                          .foregroundColor(Color(ColorTheme.current.black))
                          .fixedSize(horizontal: false, vertical: true)
                          .font(Font.system(size:17, weight: .semibold))
                            
                          .multilineTextAlignment(.leading)
                        Spacer()
                        Text("V 1.0")
                            .font(Font.system(size:12, weight: .regular))
                            .foregroundColor(Color(red: 130/255, green: 136/255, blue: 148/255))
                      }
                    }
                    }
                    /*
                    .onTapGesture {
                        showingAlert = true
                        
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Messaggio Importante"), message: Text("Sei sicuro di voler effettuare il logout?"), primaryButton: .default(Text("Logout")), secondaryButton: .cancel())
                    }*/
                    .frame(minHeight: 63)
                  }
        }
    }
    }
}

private struct TermPrivacyRowView: View {
  let title: String

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(self.title)
          .foregroundColor(Color(ColorTheme.current.black))
          .fixedSize(horizontal: false, vertical: true)
          .font(Font.system(size:17, weight: .semibold))
            
          .multilineTextAlignment(.leading)
        Spacer()
        Image(systemName: "chevron.right")
      }

      Divider()
    }
    .frame(minHeight: 63)
  }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showTerms: {}, showPrivacyPolicy: {})
    }
}
