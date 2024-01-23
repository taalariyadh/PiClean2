//
//  AfterPage.swift
//  PiClean
//
//  Created by Taala on 11/07/1445 AH.
//

import SwiftUI

struct AfterPage: View {
    var body: some View {
        
        ZStack{
            
            VStack{
                Background()
            }
            
            VStack(alignment: .center) {
                
                Text("This spot is an absolute mess!")
                    .font(Font.custom("SF Pro", size: 32))
                    .lineSpacing(-100)
                    .foregroundColor(.white)
                
                Text("Clean it up then snap a quick pic to make your planet squeaky clean!")
                    .font(Font.custom("SF Pro", size: 20))
                //                    .lineSpacing(22)
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    .font(.caption)

                
                
            }
            .padding()
           
        }
        
        
    }
    
    
}

#Preview {
    AfterPage()
}
