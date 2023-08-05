//
//  MoonShotView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 05.08.2023.
//

import SwiftUI

struct MoonShotView: View {
    let astronauts: [String: MoonShotModel] = Bundle.main.decode("astronauts.json")
    let missions: [MissionsModel] = Bundle.main.decode("missions.json")
    let columns = [
          GridItem(.adaptive(minimum: 150))
      ]

      var body: some View {
          NavigationView {
              ScrollView {
                  LazyVGrid(columns: columns) {
                      ForEach(missions) { mission in
                          NavigationLink {
                              MissionsView(mission: mission, astronauts: astronauts)
                          } label: {
                              VStack {
                                  Image(mission.image)
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 100, height: 100)
                                      .padding()

                                  VStack {
                                      Text(mission.displayName)
                                          .font(.headline)
                                          .foregroundColor(.white)

                                      Text(mission.formattedLaunchDate)
                                          .font(.caption)
                                          .foregroundColor(.white.opacity(0.5))
                                  }
                                  .padding(.vertical)
                                  .frame(maxWidth: .infinity)
                                  .background(.lightBackground)
                              }
                              .clipShape(RoundedRectangle(cornerRadius: 10))
                              .overlay(
                                  RoundedRectangle(cornerRadius: 10)
                                      .stroke(.lightBackground)
                              )
                          }
                      }
                  }
                  .padding([.horizontal, .bottom])
              }
              .navigationTitle("Moonshot")
              .background(.darkBackground)
              .preferredColorScheme(.dark)
          }
      }
  }

#Preview {
    MoonShotView()
}
