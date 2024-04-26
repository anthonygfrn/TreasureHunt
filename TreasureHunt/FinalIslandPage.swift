//
//  FinalIslandPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct FinalIslandPage: View {
    // Add treasure lock interface and UI elements here
    var body: some View {
        VStack {
            Text("Final Island - Treasure Zoom-In")
                .font(.title)
                .padding()
            
            // Example of lock interface (replace with actual lock UI)
            Text("Enter Code:")
                .font(.headline)
                .padding()
            
            // Example text field for code input
            TextField("Code", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

#Preview {
    FinalIslandPage()
}
