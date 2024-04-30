//
//  CavePage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct CavePage: View {
    @Environment(\.dismiss) private var dismiss
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var backOpacity = 0.0
    @State private var rotation = 0
    @State private var isRotate = true
    @State private var glowWidth = 650.0
    @State private var glowWidth2 = 550.0
    @State private var brightnessIlumination = 0.0
    @State private var questionMarkOpacity = 1.0
    @State private var glowWidth3 = 0.0
    @State private var posX = 840
    @State private var posY = 1000
    @State private var fireSize = 230.0
    @State private var firePosY = 1000.0
    @State private var freezingImage = "freezingSad"
    
    var body: some View {
        ZStack {
            Image("caveMapPuzzle")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            Image("backButton")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .position(CGPoint(x: 900, y: 100))
                .opacity(backOpacity)
                .onTapGesture {
                    timer.upstream.connect().cancel()
                    dismiss()
                }
            
            Image("ilumination1")
                .resizable()
                .scaledToFit()
                .frame(width: 330)
                .position(CGPoint(x: 830, y: 1000))
            
            Image("ilumination2")
                .resizable()
                .scaledToFit()
                .frame(width: 450)
                .position(CGPoint(x: 800, y: 980))
            
            Image("ilumination3")
                .resizable()
                .scaledToFit()
                .frame(width: glowWidth2)
                .position(CGPoint(x: 790, y: 950))
                .onAppear(){
                    glowAnimation()
                }
            
            Image("ilumination4")
                .resizable()
                .scaledToFit()
                .frame(width: glowWidth)
                .position(CGPoint(x: 760, y: 930))
                .onAppear(){
                    glowAnimation()
                }
            
            Image("ilumination5")
                .resizable()
                .scaledToFit()
                .frame(width: glowWidth3)
                .position(CGPoint(x: posX, y: posY))
                .opacity(brightnessIlumination)
                .onReceive(timer) { time in
                    showAnswer()
                }
            
            Image("resultCave")
                .resizable()
                .scaledToFit()
                .frame(width: 400)
                .opacity(brightnessIlumination)
                .position(CGPoint(x: 300, y: 500))
            
            Image("caveGround")
                .resizable()
                .scaledToFit()
                .frame(width: 1200)
                .position(CGPoint(x: 512, y: 1260))
            
            Image("fire")
                .resizable()
                .scaledToFit()
                .frame(width: fireSize)
                .position(CGPoint(x: 840, y: firePosY))
            
            Image("tinderBox")
                .resizable()
                .scaledToFit()
                .frame(width: 220)
                .position(CGPoint(x: 850, y: 1150))
            
            Image("questionMark")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .position(CGPoint(x: 300, y: 500))
                .rotationEffect(.degrees(Double(rotation)), anchor: UnitPoint(x: 0.1, y: 0.3))
                .onAppear(){
                    rotateAnimation()
                }
                .opacity(questionMarkOpacity)
            
            Image(freezingImage)
                .resizable()
                .frame(width: 416, height: 503, alignment: .center)
                .padding(.top, 795)
                .padding(.trailing, 543)
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func showAnswer(){
        if UIScreen.main.brightness > 0.7{
            withAnimation(Animation.linear(duration: 0.8)){
                questionMarkOpacity = 0
                posX = 500
                posY = 800
                glowWidth3 = 1240
                brightnessIlumination = 1
                fireSize = 280
                firePosY = 970
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    backOpacity = 1
                    
                    freezingImage = "freezingHappy"
                }
            }
        }
    }
    
    func rotateAnimation(){
        if isRotate {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)){
                rotation += 5
            }
        } else {
            withAnimation(Animation.linear(duration: 0)){
                rotation = 0
            }
        }
    }
    
    func glowAnimation(){
        withAnimation(Animation.linear(duration: 0.8).repeatForever(autoreverses: true)){
            glowWidth += 20
            glowWidth2 += 9
        }
    }
}

#Preview {
    CavePage()
}
