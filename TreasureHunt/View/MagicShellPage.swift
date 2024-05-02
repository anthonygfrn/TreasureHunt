//
//  MagicShellPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI
import AVFoundation

struct MagicShellPage: View {
    @State private var hintSound: AVAudioPlayer?
    @State private var buzzerSound: AVAudioPlayer?
    @State private var objectImage = "bzz"
    @State private var hintSoundCount = 0
    @Environment(\.dismiss) private var dismiss
    @State private var backOpacity = 0.0
    @State private var timer: Timer?
    @State private var widthText = 500.0

    let volumeCheckInterval = 0.5 // Adjust as needed
    let hintSoundMaxCount = 2 // Maximum number of times to play the hint sound

    var body: some View {
        ZStack {
            Image("kerang")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            Image("backButton")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .position(CGPoint(x: 900, y: 100))
                .opacity(backOpacity)
                .onTapGesture {
                    stopAllAudio() // Stop all audio when backButton is tapped
                    dismiss()
                    AudioManager.shared.playBackgroundMusic() // Resume background music
                }
            
            VStack {
                Image(objectImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: widthText)
                    .offset(x: 120)
                    .onAppear() {
                        startAnimation()
                        loadSounds()
                        startVolumeCheck()
                    }
            }
        }
        .onDisappear {
            stopAllAudio() // Stop all audio when view disappears
        }
        .navigationBarBackButtonHidden(true)
    }

    func loadSounds() {
        // Load sound files
        hintSound = loadSound(named: "circle")
        buzzerSound = loadSound(named: "bzz2")
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

    func startAnimation() {
        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            widthText = 600
        }
    }

    func startVolumeCheck() {
            // Start a timer to periodically check volume
            timer = Timer.scheduledTimer(withTimeInterval: volumeCheckInterval, repeats: true) { _ in
                let volume = getCurrentVolume()
                if volume >= 0.70 {
                    // Change object image
                    self.objectImage = "o"
                    // Stop buzzer sound
                    self.stopSound(self.buzzerSound)
                    // Play hint sound
                    self.playHintSound()
                    backOpacity = 1
                } else {
                    self.playSound(self.buzzerSound, volume: 80.0)
                }
            }
        }

    func playHintSound() {
        guard hintSoundCount < hintSoundMaxCount else {
            return // Already played hint sound max times
        }
        playSound(hintSound)
        hintSoundCount += 1
        if hintSoundCount == hintSoundMaxCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.hintSoundCount = 0 // Reset hint sound count after a delay
            }
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

    func stopSound(_ sound: AVAudioPlayer?) {
        sound?.stop()
    }

    func stopAllAudio() {
        timer?.invalidate()
        timer = nil

        stopSound(hintSound)
        stopSound(buzzerSound)
    }

    func getCurrentVolume() -> Float {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            defer {
                try? AVAudioSession.sharedInstance().setActive(false)
            }
            return AVAudioSession.sharedInstance().outputVolume
        } catch {
            print("Error getting volume: \(error)")
            return 0.0
        }
    }
}
#Preview {
    MagicShellPage()
}
