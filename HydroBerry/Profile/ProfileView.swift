//
//  ProfileView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 13/01/21.
//

import SwiftUI
import DuckMaUI

struct ProfileView: View {
    let showTerms: () -> Void
    let showPrivacyPolicy: () -> Void
    @State var showingEditProfile = false
    @State var showingAddCrop = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Profilo").multilineTextAlignment(.leading)
                        .font(Font.system(size:34, weight: .bold))
                    Spacer()
                }
                .padding(.bottom,28)
                systemPart
                Spacer()
                termsPart
                Spacer()
            }.padding()
            //.padding(.top, -80)
        
        }
        
    }
    
    
    private var systemPart: some View{
        VStack{
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
                EditProfileView(lastName: "LastName", firstName: "FirstName", email: "email@gmail.com")
            }
            
            Spacer().frame(height: 5)

            
          Button(action: self.showTerms) {
            TermPrivacyRowView(title: "Leggi termini e condizioni")
              .foregroundColor(Color(ColorTheme.current.primary.dark))
          }

          Spacer().frame(height: 5)

          Button(action: self.showPrivacyPolicy) {
            TermPrivacyRowView(title: "Leggi privacy policy")
              .foregroundColor(Color(ColorTheme.current.primary.dark))
                
          }
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
            .frame(minHeight: 63)
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
