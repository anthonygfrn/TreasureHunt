//
//  FinalIslandPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI
import AVFoundation

struct FinalIslandPage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var answerImage1 = "X"
    @State private var answerImage2 = "X"
    @State private var answerImage3 = "X"
    @State private var navigateToDiamond = false
    @State private var navigateToFish = false
    
    @State private var hint1 = "plainTriangle"
    @State private var hint2 = "plainSquare"
    @State private var hint3 = "plainCircle"
    
    @State private var tapSound: AVAudioPlayer?
    
    
    @State private var random = 0
    
    var body: some View {
        ZStack {
            Image("finalMapPage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                .onAppear(){
                    loadSounds()
                }
            
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
            
            Image("upButton")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 370, y: 570))
                .onTapGesture {
                    playSound(tapSound, volume: 80)
                    if answerImage1 == "X"{
                        answerImage1 = "star"
                    } else if answerImage1 == "star"{
                        answerImage1 = "square"
                    } else if answerImage1 == "square"{
                        answerImage1 = "triangle"
                    } else if answerImage1 == "triangle"{
                        answerImage1 = "circle"
                    } else if (answerImage1 == "circle"){
                        answerImage1 = "X"
                    }
                    
                    checkAnswer()
                }
            
            Image("upButton")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 510, y: 570))
                .onTapGesture {
                    playSound(tapSound, volume: 80)
                    if answerImage2 == "X"{
                        answerImage2 = "star"
                    } else if answerImage2 == "star"{
                        answerImage2 = "square"
                    } else if answerImage2 == "square"{
                        answerImage2 = "triangle"
                    } else if answerImage2 == "triangle"{
                        answerImage2 = "circle"
                    } else if (answerImage2 == "circle"){
                        answerImage2 = "X"
                    }
                    
                    checkAnswer()
                }
            
            Image("upButton")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 650, y: 570))
                .onTapGesture {
                    playSound(tapSound, volume: 80)
                    if answerImage3 == "X"{
                        answerImage3 = "star"
                    } else if answerImage3 == "star"{
                        answerImage3 = "square"
                    } else if answerImage3 == "square"{
                        answerImage3 = "triangle"
                    } else if answerImage3 == "triangle"{
                        answerImage3 = "circle"
                    } else if (answerImage3 == "circle"){
                        answerImage3 = "X"
                    }
                    
                    checkAnswer()
                }
            
            Image("downButton")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 370, y: 780))
                .onTapGesture {
                    playSound(tapSound, volume: 80)
                    if answerImage1 == "X"{
                        answerImage1 = "circle"
                    } else if answerImage1 == "star"{
                        answerImage1 = "X"
                    } else if answerImage1 == "square"{
                        answerImage1 = "star"
                    } else if answerImage1 == "triangle"{
                        answerImage1 = "square"
                    } else if (answerImage1 == "circle"){
                        answerImage1 = "triangle"
                    }
                    
                    checkAnswer()
                }
            
            Image("downButton")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 510, y: 780))
                .onTapGesture {
                    playSound(tapSound, volume: 80)
                    if answerImage2 == "X"{
                        answerImage2 = "circle"
                    } else if answerImage2 == "star"{
                        answerImage2 = "X"
                    } else if answerImage2 == "square"{
                        answerImage2 = "star"
                    } else if answerImage2 == "triangle"{
                        answerImage2 = "square"
                    } else if (answerImage2 == "circle"){
                        answerImage2 = "triangle"
                    }
                    
                    checkAnswer()
                }
            
            
            Image("downButton")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 650, y: 780))
                .onTapGesture {
                    playSound(tapSound, volume: 80)
                    if answerImage3 == "X"{
                        answerImage3 = "circle"
                    } else if answerImage3 == "star"{
                        answerImage3 = "X"
                    } else if answerImage3 == "square"{
                        answerImage3 = "star"
                    } else if answerImage3 == "triangle"{
                        answerImage3 = "square"
                    } else if (answerImage3 == "circle"){
                        answerImage3 = "triangle"
                    }
                    
                    checkAnswer()
                }
            
            Image(answerImage1)
                .resizable()
                .scaledToFit()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .position(CGPoint(x: 370, y: 675))
            
            Image(answerImage2)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .position(CGPoint(x: 510, y: 675))
            
            Image(answerImage3)
                .resizable()
                .scaledToFit()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .position(CGPoint(x: 650, y: 675))
            
            
        }
        .navigationBarBackButtonHidden(true)
        
        NavigationLink(destination: DiamondView(), isActive: $navigateToDiamond) {
            EmptyView()
        }
        
        NavigationLink(destination: FishView(), isActive: $navigateToFish) {
            EmptyView()
        }
    }
    func checkAnswer(){
        if answerImage1 == "triangle" &&
            answerImage2 == "square" &&
            answerImage3 == "circle"{
            random = Int.random(in: 1...2)
            if random == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigateToDiamond.toggle()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigateToFish.toggle()
                }
            }
        }
    }
    
    func loadSounds() {
        tapSound = loadSound(named: "tapSound")
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
    FinalIslandPage()
}
