//
//  TreasureHuntView.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI
import AVFoundation

struct TreasureHuntView: View {
    var body: some View {
        NavigationStack {
                LandingPage()
        }
        .onAppear {
                 // Start playing background audio
                 AudioManager.shared.playBackgroundMusic()
             }
    }
}

class AudioManager {
 static let shared = AudioManager()
 
 var audioPlayer: AVAudioPlayer?

 func playBackgroundMusic() {
     if let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
         do {
             audioPlayer = try AVAudioPlayer(contentsOf: url)
             audioPlayer?.numberOfLoops = -1 // Set to loop indefinitely
             audioPlayer?.play()
         } catch {
             print("Error playing background music: \(error.localizedDescription)")
         }
     } else {
         print("Background music file not found")
     }
 }
}

#Preview {
    TreasureHuntView()
}
