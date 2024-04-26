//
//  MapPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct MapPage: View {
    var body: some View {
        ZStack {
            Image("map")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                NavigationLink(destination: CoconutTreePage()) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(destination: CavePage()) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(destination: MagicShellPage()) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(destination: FinalIslandPage()) {
                    Image(systemName: "mappin")
                        .font(.system(size: 140))
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    MapPage()
}
