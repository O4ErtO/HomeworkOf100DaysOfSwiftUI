//
//  SwiftUIView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 05.08.2023.
//

import SwiftUI

struct AstronautsView: View {
    let astronaut: MoonShotModel

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: MoonShotModel] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautsView(astronaut: astronauts["armstrong"]!)
    }
}
