//
//  SwiftUIView.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 10/01/21.
//

import SwiftUI

struct SwiftUIView: View {
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
