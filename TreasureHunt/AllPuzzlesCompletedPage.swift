//
//  AllPuzzlesCompletedPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct AllPuzzlesCompletedPage: View {
    var body: some View {
        Text("Congratulations!\nYou've solved all the puzzles.")
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    AllPuzzlesCompletedPage()
}
