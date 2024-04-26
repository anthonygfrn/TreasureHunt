//
//  ContentView.swift
//  TreasureHunt
//
//  Created by Anthony on 24/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: MapPage()) {
                LandingPage()
            }
        }
    }
}


#Preview {
    ContentView()
}
