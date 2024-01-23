//
//  Background.swift
//  PiClean
//
//  Created by Taala on 11/07/1445 AH.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ImagesView(imageNames: ["Image1", "Image2", "Image3", "Image4","Image5","Image6","Image7","Image8","Image9","Image10","Image11","Image12","Image13","Image15","Image16","Image17","Image16","Image19","Image20","Image21","Image22"])
                        }
                    }
                }

    struct ImagesView: View {
                    let imageNames: [String]

                    var body: some View {
                        ZStack {
                            ForEach(imageNames, id: \.self) { imageName in
                                ImageView(imageName: imageName)
                            }
                        }
                    }
                }

                struct ImageView: View {
                    let imageName: String
                    @State private var scale: CGFloat = 1.0

                    var body: some View {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .scaleEffect(scale)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                                    self.scale = 1.2
                                }
                            }
                            .position(initialPosition())
                    }

                    private func initialPosition() -> CGPoint {
                        let screenWidth = UIScreen.main.bounds.width
                        let screenHeight = UIScreen.main.bounds.height

                        let x = CGFloat.random(in: 0...screenWidth)
                        let y = CGFloat.random(in: 0...screenHeight)

                        return CGPoint(x: x, y: y)
                    }
                }




#Preview {
    Background()
}
