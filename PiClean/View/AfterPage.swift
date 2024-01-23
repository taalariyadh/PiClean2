//
//  AfterPage.swift
//  PiClean
//
//  Created by Taala on 11/07/1445 AH.
//

import SwiftUI

struct AfterPage: View {
    @State private var showCamera = false

    var body: some View {
        GeometryReader { geometry in
            
            ZStack{
                
                Background()
                
                
                VStack(alignment: .center) {
                    
                    Text("This spot is an absolute mess!")
                        .font(Font.custom("SF Pro", size: 32))
//                        .lineSpacing(-100)
                        .foregroundColor(.white)
                    
                    Text("Clean it up then snap a quick pic to make your planet squeaky clean!")
                        .font(Font.custom("SF Pro", size: 20))
                    //                    .lineSpacing(22)
                        .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                        .font(.caption)
                        
                }  .padding()
                
                    Button(action: {
                        showCamera.toggle()
                        
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("ButtonColor"))
                                .frame(width:148, height: 44, alignment: .center)
                                .cornerRadius(12)
                            
                            
                            Text("I'm ready")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                //.bold()
                                .accessibilityLabel("This is a button to get started")
                            
                            
                        }  .padding(.top, geometry.size.height * 0.79)
                        
                    }
                    
                    
                    
                    
                    
                
               
                
            } //end ZStack
        }// end geo
        
        
    }
    
    
}

#Preview {
    AfterPage()
}
