//
//  PiCleanApp.swift
//  PiClean
//
//  Created by Reema Alfaleh on 06/07/1445 AH.
//

import SwiftUI

@main
struct PiCleanApp: App {
    @StateObject var vm = ViewModel()

    var body: some Scene {
        WindowGroup {
       
            splash()
                .environmentObject(vm)
                .preferredColorScheme(.dark)

            
        }
    }
}
