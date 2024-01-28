////
////  AlertView.swift
////  PiClean
////
////  Created by Reema Alfaleh on 16/07/1445 AH.
////
//
//import SwiftUI
//
//struct AlertView: View {
//    @EnvironmentObject var vm : ViewModel
//
//    var body: some View {
//        
//        if let result = vm.classificationResult2 {
//            //DispatchQueue.main.async {
//                switch result {
//                case "Clean":
//                    vm.selectedImage1 = nil
//                    vm.selectedImage2 = nil
//                    vm.isShowingCleanAlert?.toggle()
//                    print("Clean")
//                case "UnClean":
//                    vm.selectedImage1 = nil
//                    vm.selectedImage2 = nil
//                    vm.isShowingUnCleanAlert?.toggle()
//                    print("UnClean")
//                default:
//                    BandF()
//                    print("Default")
//                }
//              // }
//            
//           }
//            .alert(isPresented: $vm.isShowingCleanAlert?) {
//                Alert(
//    title: Text(NSLocalizedString("Thank you for the positive impact you've made on the environment", comment: "")),
//    dismissButton: .default(Text("Continue"))
//                                          )
//             
//    }
//}
//
//#Preview {
//    AlertView()
//}
