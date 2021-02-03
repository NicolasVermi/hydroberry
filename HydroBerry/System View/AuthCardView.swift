//
//  AuthCardView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 11/01/21.
//

import SwiftUI

struct AuthCardView: View {
    @StateObject var viewModel = SystemViewModel()
    @State var raccoltoID: String

    var mail: String
    
    var body: some View {
        VStack{
        HStack{
            Text(mail)
            Spacer()
            Button(action:{ viewModel.deleteAuthPeople(email: mail, raccoltoID: raccoltoID) ; print("Da eliminare")}){
                Image("ic_exit")
            }
        }.padding()
        Rectangle()
            .foregroundColor(Color(red: 229/255, green: 231/255, blue: 235/255))
            .frame(height:1)
            .padding(.horizontal)
        }
    }
}

struct AuthCardView_Previews: PreviewProvider {
    static var previews: some View {
        AuthCardView(raccoltoID: "", mail: "mariorossi@gmail.com")
    }
}
