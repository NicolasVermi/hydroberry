//
//  prova2View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 12/01/21.
//

import SwiftUI

struct prova2View: View {
    @State var showingDetail = false

    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            
            Text("Show Information")

        }.sheet(isPresented: $showingDetail) {
            AddCropStep1View()
        }
    }
    
}

struct prova2View_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
