import SwiftUI

struct splash: View {
    var body: some View {
       
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack(spacing: 40) {
                    
                    Image("cleanPlanet").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .offset(y: 100)
                    
                    
                    PageView()
                  
                }
            
        }.foregroundColor(.white) .multilineTextAlignment(.center)
        }
    }
struct Splash1: View {
   
        var body: some View {
            VStack(spacing: 40) {
                Text("Think green, keep it clean!")
                    .font(.system(size: 30))
                
                Text("Help us make this earth squeaky clean by showing off your cleaning skills!")
                    .font(.system(size: 19))
                    .foregroundColor(.gray)
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
        }
    }


struct Splash2: View {
    @State private var showPage = false
    var body: some View {

                VStack(spacing: 20) {
                    Text("How it works")
                        .font(.system(size: 30))
                    
                    Text("""
                1. Spot it: Find a messy spot.
                2. Snap it: Capture the 'before' snapshot.
                3. Clean it: Work your magic!
                4. Snap it again: Document the spotless victory!
                """).lineSpacing(10)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)

                    
                    Button(action: {
                        self.showPage.toggle()
                    }){
                        Text("continue").padding(15)
                        .foregroundColor(.white)
                    }
                    .fullScreenCover(isPresented: $showPage) {
                        CameraView()
             
                }

                }
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .edgesIgnoringSafeArea(.all) // Fill the entire screen
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the entire screen.navigationBarHidden(true)
                
            .background(Color(.black))
            
        }
       
            }

struct PageView: View {
    var splashes: [AnyView] = [AnyView(Splash1()), AnyView(Splash2())]
    
    var body: some View {
        GeometryReader{ geometry in
            TabView {
                ForEach(0..<splashes.count) { i in
                    splashes[i]
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .padding([.top, .bottom], 60)
                        .padding([.leading, .trailing], 10)
                }
            }
            .frame(width: geometry.size.width)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
#Preview {
    splash()
}
