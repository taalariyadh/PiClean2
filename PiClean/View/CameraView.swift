import SwiftUI
import CoreML
import PhotosUI
import Vision

extension UIImage: Identifiable
{
    func pixelBuffer() -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(self.size.width),
                                         Int(self.size.height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs,
                                         &pixelBuffer)
        
        guard let buffer = pixelBuffer, status == kCVReturnSuccess else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])
        defer { CVPixelBufferUnlockBaseAddress(buffer, []) }

        let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer),
                                width: Int(self.size.width),
                                height: Int(self.size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        guard let cgImage = self.cgImage, let ctx = context else {
            return nil
        }

        ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        return buffer
    }
}

struct CameraView: View {
    
    @State private var showCamera = false
    @State private var selectedImage: UIImage?
    @State private var showClass = false
    @State private var classificationResult: String?

    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack {
                    
                    Text("Lets Save Our Planet!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
               //  position(x: geometry.size.width  , y: geometry.size.height)
                    
                    
                    Image("DirtyPlanet")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                        .frame(width: 250, height: 250)
                    
                    
                    Button(action: {
                        self.showCamera.toggle()
                        
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("ButtonColor"))
                                .frame(width:170, height: 70)
                            
                            
                            
                            Text("Get Started")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .bold()
                                .cornerRadius(40)
                                .opacity(0.9)
                                .accessibilityLabel("This is a button to get started")
                            
                        }
                        
                    }
                    
                    
                    
                }
            }
        }
                    
                    
                    .fullScreenCover(isPresented: self.$showCamera) {
                        accessCameraView(selectedImage: self.$selectedImage)
                            .ignoresSafeArea()
                    } // end fullScreenCover
                    
                   
          
        }
    
    }// end view

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
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: accessCameraView
        let model: PiCleanClassifier_1
        var classificationResult: String? // Declare here

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
       
        self.picker.isPresented.wrappedValue.dismiss()
    }


    }

    #Preview {
       CameraView()
            .environment(\.locale, .init(identifier:"ar"))
        
    }


