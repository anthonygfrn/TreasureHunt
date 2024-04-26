//
//  TreasureOpenedPage.swift
//  TreasureHunt
//
//  Created by Anthony on 26/04/24.
//

import SwiftUI

struct TreasureOpenedPage: View {
    var body: some View {
        Text("Congratulations!\nYou've found the treasure!")
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    TreasureOpenedPage()
}
