//
//  LandingPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct LandingPage: View {
    @State private var isAnimating = false
    @State private var navigateToMap = false
    
    var body: some View {
        ZStack {
            Image("landing")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Button(action: {
                    // Action when the play button is tapped
                    self.isAnimating = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isAnimating = false
                        self.navigateToMap = true // Set navigateToMap to true after animation
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.red, .yellow)
                        .scaleEffect(isAnimating ? 1.2 : 1.0) // Scale effect on animation
                        .animation(Animation.easeInOut(duration: 0.5), value: isAnimating)
                }
                .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the button's default styling
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $navigateToMap) {
            MapPage(posX: 230.0, posY: 1090.0)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LandingPage()
}
