//
//  CoconutTreePage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

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
    
    var body: some View {
        ZStack {
            Image("coconutMapPuzzle")
                .resizable()
                .scaledToFill()
            
            Image("backButton")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .position(CGPoint(x: 900, y: 100))
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
                    withAnimation(.linear(duration: 1)){
                        coconutHeight = 930
                        shakeOpacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        isRotate = false
                        placeholderImage = "resultCoconut"
                        rotateAnimation()
                        backOpacity = 1
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
