import SwiftUI

struct BandF: View {
    @EnvironmentObject var vm1 : ViewModel
    @EnvironmentObject var vm2 : ViewModel
    @State private var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @State private var showView = false

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
                        
                        if let image1 = vm1.selectedImage{
                            Image(uiImage: image1)
                                .resizable()
                                .foregroundColor(.clear)
                                .frame(width: 160, height: 176)
                                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        }
                        
                        
                        if let image2 = vm2.selectedImage2{
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
                    //self.showView.toggle()
                    vm2.selectedImage = nil
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
        
//        .fullScreenCover(isPresented: $showView) {
//            CameraView()
//        }
    }
    }


#Preview {
    BandF()
  
}
