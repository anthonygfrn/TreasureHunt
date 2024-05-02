//
//  FishView.swift
//  TreasureHunt
//
//  Created by Annisa Az Zahra on 28/04/24.
//

import SwiftUI
import AVFoundation

struct FishView: View {
    @State private var navigateToLandingPage = false
    @State private var failSound: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("coconutTree")
                    .resizable()
                    .frame(width: 932.62695, alignment: .center)
                    .padding(.bottom, 398)
                    .padding(.top, -333)
                    .padding(.leading, 700)
                    .onAppear(){
                        loadSounds()
                        playSound(failSound, volume: 80)
                    }
                
                Ellipse()
                    .frame(width: 1461.01489, height: 608)
                    .foregroundColor(Color(red: 0.92, green: 0.8, blue: 0.59))
                    .padding([.bottom, .trailing], 51)
                    .padding([.top], 707)
                
                
                ZStack {
                    Image("chestTop")
                        .resizable()
                        .frame(width: 850, height: 466)
                        .padding([.top],179)
                        .padding([.bottom],721)
                    
                    Image("Fish")
                        .resizable()
                        .frame(width: 1029.74939, height: 652.0835, alignment: .center)
                        .padding([.top],439)
                        .padding([.bottom],643)
                    
                    Image("chestBottom")
                        .resizable()
                        .frame(width: 850, height: 466)
                        .padding([.top],643)
                        .padding([.bottom],256)
                    
                    Image("codeInput")
                        .resizable()
                        .frame(width: 440.38, height: 316.89505)
                        .padding([.top],525)
                        .padding([.bottom],524)
                }
                
                Image("Grass")
                    .resizable()
                    .frame(width: 396.42371, height: 214.86255)
                    .padding([.top],729)
                    .padding([.trailing], 800)
                
                
                UnhappyFaceView()
                    .padding([.top],254)
                    .padding([.bottom],883)
                    .padding([.leading],502)
                
                UnhappyFaceView()
                    .padding([.top],400)
                    .padding([.bottom],883)
                    .padding([.trailing],502)
                
                UnhappyFaceView()
                    .padding([.top],0)
                    .padding([.bottom],900)
                
                // Redirect to landingPage
                Image("replay")
                    .resizable()
                    .frame(width: 188, height: 188)
                    .padding(.bottom, 71)
                    .padding(.top, 1164)
                    .padding(.leading, 772)
                
                // Tombol dengan gambar yang berfungsi sebagai navigasi
                Button(action: {
                    // Aksi ketika tombol ditekan, navigasi ke landingPage
                    self.navigateToLandingPage = true
                }) {
                    Image("replay")
                        .resizable()
                        .frame(width: 188, height: 188)
                        .padding(.bottom, 71)
                        .padding(.top, 1164)
                        .padding(.leading, 772)
                }
                .background(
                    NavigationLink(
                        destination: LandingPage(), // Ganti dengan tampilan landingPage yang sesuai
                        isActive: $navigateToLandingPage,
                        label: {
                            EmptyView()
                        }
                    )
                )
            }
            .frame(width: 1024, height: 1366)
            .background(Color(red: 1, green: 0.9, blue: 0.71))
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
        
        
    }
    func loadSounds() {
        failSound = loadSound(named: "failSound")
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
    FishView()
}
