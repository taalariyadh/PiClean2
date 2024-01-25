import SwiftUI
import CoreML
import PhotosUI
import Vision

struct AfterPage: View {
    @State private var showCamera = false
    @State private var selectedImage2: UIImage?
    @State private var showClass = false
    @State private var classificationResult: String?
    @EnvironmentObject var vm2 : ViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Background()
                
               // VStack {
                    
                   if  let image2 = vm2.selectedImage2{
                        
                        BandF()
                    }
                    else{
                        
                        VStack(alignment: .center) {
                          //  Spacer()
                Text("This spot is an absolute mess!")
                                .font(Font.custom("SF Pro", size: 32))
                                .foregroundColor(.white)
                            
                  Text("Clean it up then snap a quick pic to make your planet squeaky clean!")
                                .font(Font.custom("SF Pro", size: 20))
                                .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                                .font(.caption)
                            
                        } .padding()
                        
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
    
                    }
    
                //} //end ZStack
                
            }// end geo
            
            .fullScreenCover(isPresented: self.$showCamera ) {
                accessCameraView(selectedImage: $vm2.selectedImage2)
                    .interactiveDismissDisabled()
                    .ignoresSafeArea()
                
            } // end fullScreenCover
        }
    }
    
        struct accessCameraView: UIViewControllerRepresentable {
            
            @Binding var selectedImage: UIImage?
            @Environment(\.presentationMode) var isPresented
            
            func makeUIViewController(context: Context) -> UIImagePickerController {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                imagePicker.delegate = context.coordinator
                return imagePicker
            }
            
            func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
                
            }
            
            func makeCoordinator() -> Coordinator {
                return Coordinator(picker: self)
                
            }
        } //SwiftUI representation of a UIViewController that uses the camera to capture an image.
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var picker: accessCameraView
            let model: PiCleanClassifier_1
            var classificationResult: String?
            
            init(picker: accessCameraView) {
                self.picker = picker
                self.model = PiCleanClassifier_1()
                super.init()
            }
            
            func processImage(_ image: UIImage) {
                if let pixelBuffer = image.pixelBuffer() {
                    do {
                        let output = try model.prediction(input: PiCleanClassifier_1Input(image: pixelBuffer))
                        // Access and handle the model's output
                        self.classificationResult = output.target
                        
                        print("Classification result: \( self.classificationResult)")
                        
                    } catch {
                        print("Error: \(error)")
                    }
                    
                }
                
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                guard let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else {
                    return
                }
                self.picker.selectedImage = selectedImage
                processImage(selectedImage)
                
                //selectedImage variable represents the image selected or captured by the user using the camera
                
                self.picker.isPresented.wrappedValue.dismiss()
            } // This function gets called when the user has selected or taken a photo using the camera
            
        }
        
    }
    
#Preview {
    AfterPage()
        .environment(\.locale, .init(identifier:"PiClean"))
        .environmentObject(ViewModel())

}
