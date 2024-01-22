//
//  Mainpage.swift
//  PiClean
//
//  Created by shaden alangari on 09/07/1445 AH.
//

import SwiftUI

struct Mainpage: View {
    var body: some View {
        Text("Mainpage View")
                   .padding()
                   .navigationBarTitle("Mainpage", displayMode: .inline)
                   .navigationBarHidden(true) // Hide the navigation bar in Mainpage
                   
        
    }
}

#Preview {
    Mainpage()
}
