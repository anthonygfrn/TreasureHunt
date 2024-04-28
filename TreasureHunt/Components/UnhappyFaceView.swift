//
//  UnhappyFaceView.swift
//  TreasureHunt
//
//  Created by Annisa Az Zahra on 28/04/24.
//

import SwiftUI

struct UnhappyFaceView: View {
    @State private var isRotatedRight = true
    let rotationAngle: Double = 15.0
    let animationDuration: Double = 0.5
    
    var body: some View {
        Image("UnhappyFace")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120.0, height: 169.0)
            .rotationEffect(Angle(degrees: isRotatedRight ? rotationAngle : -rotationAngle))
            .onAppear {
                // Start the animation loop
                rotate()
            }

    }
    func rotate() {
        withAnimation(Animation.easeInOut(duration: animationDuration)) {
            // Toggle the rotation direction
            self.isRotatedRight.toggle()
        }

        // Schedule the next rotation
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            rotate()
        }
    }
    
}

#Preview {
    UnhappyFaceView()
}
