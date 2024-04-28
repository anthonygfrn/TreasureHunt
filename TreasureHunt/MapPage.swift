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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
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
            Image("character")
                .resizable()
                .frame(width: 300.0, height: 300.0)
                .scaledToFit()
                .position(x: posX, y:posY)
                .animation(.easeInOut(duration: 1), value: isAnimating)
        }
        .navigationBarBackButtonHidden(true)
        NavigationLink(destination: FinalIslandPage(), isActive: $navigateToFinal) {
            EmptyView()
        }
        NavigationLink(destination: MagicShellPage(), isActive: $navigateToShell) {
            EmptyView()
        }
        NavigationLink(destination: CavePage(), isActive: $navigateToCave) {
            EmptyView()
        }
        NavigationLink(destination: CoconutTreePage(), isActive: $navigateToCoconut) {
            EmptyView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MapPage(posX: 230.0, posY: 1090.0)
}
