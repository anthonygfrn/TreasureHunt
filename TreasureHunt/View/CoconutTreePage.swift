//
//  CoconutTreePage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI
import AVFoundation

struct CoconutTreePage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var backOpacity = 0.0
    @State private var posXRight = 450
    @State private var posXLeft = 50
    @State private var rotation = 0
    @State private var isRotate = true
    @State private var coconutHeight = 400
    @State private var placeholderImage = "questionMark"
    @State private var shakeOpacity = 1.0
    
    @State private var fallingSound: AVAudioPlayer?
    @State private var successSound: AVAudioPlayer?
    
    @State private var hint1 = "questionMark"
    @State private var hint2 = "questionMark"
    @State private var hint3 = "questionMark"
    
    var body: some View {
        ZStack {
            Image("coconutMapPuzzle")
                .resizable()
                .scaledToFill()
            
            Image("backButton")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .position(CGPoint(x: 850, y: 125))
                .opacity(backOpacity)
                .onTapGesture {
                    dismiss()
                }
            
            Image("singleCoconut")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .position(CGPoint(x: 370, y: coconutHeight))
                .onShake {
                    loadSounds()
                    playSound(fallingSound, volume: 100)
                    withAnimation(.linear(duration: 1)){
                        coconutHeight = 930
                        shakeOpacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        isRotate = false
                        placeholderImage = "resultCoconut"
                        rotateAnimation()
                        backOpacity = 1
                        playSound(successSound , volume: 100)
                        hint1 = "plainTriangle"
                    }
                }
            
            Image("Grass")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .position(CGPoint(x: 300, y: 900))
            
            Image("shakeIconRight")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .position(CGPoint(x: posXRight, y: 700))
                .opacity(shakeOpacity)
            
            Image("shakeIconLeft")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .position(CGPoint(x: posXLeft, y: 600))
                .onAppear(){
                    shakeAnimation()
                }
                .opacity(shakeOpacity)
            
            Image(placeholderImage)
                .resizable()
                .scaledToFit()
                .frame(width: 370)
                .position(CGPoint(x: 700, y: 1050))
                .rotationEffect(.degrees(Double(rotation)), anchor: UnitPoint(x: 0.8, y: 0.9))
                .onAppear(){
                    rotateAnimation()
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
            .position(CGPoint(x: 220, y: 100))
            
        }
        .navigationBarBackButtonHidden(true)
    }
    func shakeAnimation(){
        withAnimation(Animation.linear(duration: 0.08).repeatForever(autoreverses: true)){
            posXLeft += 5
            posXRight -= 5
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
    
    func loadSounds() {
        // Load sound files
        fallingSound = loadSound(named: "dropSound")
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

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

#Preview {
    CoconutTreePage()
}
