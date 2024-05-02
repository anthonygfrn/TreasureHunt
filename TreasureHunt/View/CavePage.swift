//
//  CavePage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI
import AVFoundation

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
    @State private var fireSize = 150.0
    @State private var firePosY = 1050.0
    @State private var freezingImage = "freezingSad"
    @State private var cnt = 0
    
    @State private var fireCracklingSound: AVAudioPlayer?
    @State private var fireWhoosh: AVAudioPlayer?
    @State private var successSound: AVAudioPlayer?
    @State private var soundVolume:Float = 60
    
    @State private var hint1 = "questionMark"
    @State private var hint2 = "questionMark"
    @State private var hint3 = "questionMark"
    
    
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
                .position(CGPoint(x: 850, y: 125))
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
                    loadSounds()
                    playSound(fireCracklingSound, volume: soundVolume, loop: true)
                }
                .opacity(questionMarkOpacity)
            
            Image(freezingImage)
                .resizable()
                .frame(width: 416, height: 503, alignment: .center)
                .padding(.top, 795)
                .padding(.trailing, 543)
            
            HStack {
                ZStack {
                    Image("hintBox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)
                    
                    Image("plainTriangle")
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
            .position(CGPoint(x: 220, y: 100))
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
                if (cnt == 0){
                    playSound(fireWhoosh, volume: 80)
                    cnt += 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                    if cnt == 0{
//                        fireWhoosh?.stop()
//                        cnt+=1
//                    }
                    backOpacity = 1
                    freezingImage = "freezingHappy"
                    hint2 = "plainSquare"
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
    
    func loadSounds() {
        // Load sound files
        fireCracklingSound = loadSound(named: "fireCrackling")
        fireWhoosh = loadSound(named: "fireWhoosh")
        successSound = loadSound(named: "sparkleEffect")
    }

    func loadSound(named name: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return nil
        }
        do {
            return try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Error loading sound \(name): \(error)")
            return nil
        }
    }
    
    func playSound(_ sound: AVAudioPlayer?, volume: Float? = nil, loop: Bool = false) {
        guard let sound = sound else {
            return
        }
        sound.stop()
        sound.currentTime = 0
        sound.numberOfLoops = loop ? -1 : 0
        if let volume = volume {
            sound.volume = volume
        }
        sound.play()
    }
}

#Preview {
    CavePage()
}
