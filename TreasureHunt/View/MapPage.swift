//
//  MapPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct MapPage: View {
    
    @State private var isAnimating = false
    @State private var navigateToCoconut = false
    @State private var navigateToCave = false
    @State private var navigateToShell = false
    @State private var navigateToFinal = false
    @State private var hint1 = "questionMark"
    @State private var hint2 = "questionMark"
    @State private var hint3 = "questionMark"
    
    @State var posX: Double
    @State var posY: Double
    
    var body: some View {
        ZStack {
            Image("map without player")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                ZStack {
                    Button(action: {
                        self.isAnimating = true
                        self.posX = 800
                        self.posY = 200
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.isAnimating = false
                            self.navigateToFinal = true
                        }
                    }) {
                        Image(systemName: "mappin")
                            .font(.system(size: 140))
                            .foregroundColor(.red)
                            .padding()
                            .opacity(0)
                    }
                }
                .position(x: 760, y: 260)
                
                Button(action: {
                    self.isAnimating = true
                    self.posX = 370
                    self.posY = 270
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.isAnimating = false
                        self.navigateToShell = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        hint3 = "plainCircle"
                    }
                }) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                        .opacity(0)
                }
                .position(x: 330, y: -30)
                
                
                Button(action: {
                    self.isAnimating = true
                    self.posX = 290
                    self.posY = 600
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.isAnimating = false
                        self.navigateToCave = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        hint2 = "plainSquare"
                    }
                }) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                        .opacity(0)
                }
                .position(x: 250, y: -20)
                
                Button(action: {
                    self.isAnimating = true
                    self.posX = 800
                    self.posY = 1050
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.isAnimating = false
                        self.navigateToCoconut = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                        hint1 = "plainTriangle"
                    }
                }) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                        .opacity(0)
                }
                .position(x: 760, y: 100)
            }
            .padding()
            Image("characterFull")
                .resizable()
                .frame(width: 300.0, height: 300.0)
                .scaledToFit()
                .position(x: posX, y:posY)
                .animation(.easeInOut(duration: 1), value: isAnimating)
            
            HStack {
                ZStack {
                    Image("hintBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                    
                    Image(hint1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                }
                ZStack {
                    Image("hintBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                    
                    Image(hint2)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                }
                ZStack {
                    Image("hintBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                    
                    Image(hint3)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                }
            }
            .position(CGPoint(x: 220, y: 80))
            
        }
        .navigationBarBackButtonHidden(true)

        .navigationDestination(isPresented: $navigateToFinal) {
            FinalIslandPage()
        }
        
        .navigationDestination(isPresented: $navigateToShell) {
            MagicShellPage()
        }
        
        .navigationDestination(isPresented: $navigateToCave) {
            CavePage()
        }
        
        .navigationDestination(isPresented: $navigateToCoconut) {
            CoconutTreePage()
        }
        .onAppear(){
            UIScreen.main.brightness = 0.5
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
                 AudioManager.shared.playBackgroundMusic()
             }
    }
}

#Preview {
    MapPage(posX: 230.0, posY: 1090.0)
}
