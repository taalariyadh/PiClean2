import SwiftUI

struct BandF: View {
    @EnvironmentObject var vm : ViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader{ geometry in
            
            
            ZStack{
                
                Background()
                
                VStack{
                    HStack(alignment: .top, spacing: 99){
                        
                        Text("Before")
                            .font(.headline)
                            .lineSpacing(22)
                            .foregroundColor(.white);
                        
                        Text("After")
                            .font(.headline)
                            .lineSpacing(22)
                            .foregroundColor(.white)
                    }
                    
                    HStack{
                        
                        if let image1 = vm.selectedImage1{
                            Image(uiImage: image1)
                                .resizable()
                                .foregroundColor(.clear)
                                .frame(width: 160, height: 176)
                                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        }
                        
                        
                        if let image2 = vm.selectedImage2{
                            Image(uiImage: image2)
                                .resizable()
                                .foregroundColor(.clear)
                                .frame(width: 160, height: 176)
                                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        }
                    }
                    
                    
                    Text("The power of small details \n leading to remarkable results !")
                        .bold()
                        .foregroundColor(.white)
                }
                    
            
                Button(action: {
                    vm.selectedImage1 = nil
                    vm.selectedImage2 = nil
                    if let result = vm.classificationResult2 {
                     
                            switch result {
                            case "Clean":
                                self.vm.isShowingCleanAlert?.toggle()
                                print("Clean")
                            case "UnClean":
                                self.vm.isShowingUnCleanAlert?.toggle()
                                print("UnClean")
                            default:
                                BandF()
                                print("Default")
                            }
                        
                       }
                    
                    }) {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("ButtonColor"))
                                .frame(width:148, height: 44, alignment: .center)
                                .cornerRadius(12)
                            
                            
                            Text("Done")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .accessibilityLabel("Done Button ")
                        }
                        
                    } .padding(.top, geometry.size.height * 0.6)
                   
                    
                }
            
   
            }
        
        }
    }

#Preview {
    BandF()
        .environmentObject(ViewModel())

  
}
