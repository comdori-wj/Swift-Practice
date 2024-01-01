//
//  ContentView.swift
//  SwiftUI-Essentials
//
//  Created by Wonji Ha on 2024/01/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                Spacer()
                Text("California")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
