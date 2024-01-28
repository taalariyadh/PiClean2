import SwiftUI
import CoreML
import PhotosUI
import Vision

struct AfterPage: View {
    @State private var showCamera = false
   // @State private var selectedImage2: UIImage?
    @State private var showClass = false
    @State private var classificationResult: String?
    @EnvironmentObject var vm : ViewModel
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Background()
                
               // VStack {
                    
                   if  let image2 = vm.selectedImage2{
                        
                        BandF()
                    }
                    else{
                        VStack(alignment: .center) {
            
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
                accessCameraView(selectedImage2: $vm.selectedImage2, vm: vm)
                    .interactiveDismissDisabled()
                    .ignoresSafeArea()
                
            } // end fullScreenCover
        }
    }
    
        struct accessCameraView: UIViewControllerRepresentable {
            
            @Binding var selectedImage2: UIImage?
            @Environment(\.presentationMode) var isPresented
            var vm: ViewModel
            init(selectedImage2: Binding<UIImage?>, vm: ViewModel) {
                  self._selectedImage2 = selectedImage2
                  self.vm = vm
              }
            
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
                return Coordinator(picker: self, vm: vm)
                
            }
        } //SwiftUI representation of a UIViewController that uses the camera to capture an image.
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var picker: accessCameraView
            let model: PiCleanClassifier_1
            var vm: ViewModel

            
            init(picker: accessCameraView , vm: ViewModel) {
                self.picker = picker
                self.model = PiCleanClassifier_1()
                self.vm = vm
                super.init()
            }
            
            func processImage(_ image: UIImage) {
                if let pixelBuffer = image.pixelBuffer() {
                    do {
                        let output = try model.prediction(input: PiCleanClassifier_1Input(image: pixelBuffer))
                        // Access and handle the model's output
                        self.vm.classificationResult2 = output.target
                        print("Classification result: \(self.vm.classificationResult2)")
                        
                    } catch {
                        print("Error: \(error)")
                    }
                    
                }
                
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                guard let selectedImage2 = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else {
                    return
                }
                self.picker.selectedImage2 = selectedImage2
                processImage(selectedImage2)
                
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
