//
//  SwiftUIView.swift
//  PiClean
//
//  Created by Reema Alfaleh on 11/07/1445 AH.
//


        import SwiftUI

        struct ContentView: View {
            @State private var isLoading = true
            
            var body: some View {
                Text("Hello")
                    .modifier(LoadingAlert(isPresented: $isLoading))
            }
        }

        struct LoadingAlert: ViewModifier {
            @Binding var isPresented: Bool

            func body(content: Content) -> some View {
                content
                    .alert(isPresented: $isPresented) {
                        Alert(title: Text(NSLocalizedString("Thank you for the positive impact you've made on the environment. ", comment: "")),
                              
                              dismissButton: .default(Text("Continue")) )
                    }
            }
        }


#Preview {
    ContentView()
}
