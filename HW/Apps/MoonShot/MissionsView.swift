//
//  MissionsView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 05.08.2023.
//

import SwiftUI

struct MissionsView: View {
    
    struct CrewMember {
           let role: String
           let astronaut: MoonShotModel
       }

       let mission: MissionsModel
       let crew: [CrewMember]

       var body: some View {
           GeometryReader { geometry in
               ScrollView {
                   VStack {
                       Image(mission.image)
                           .resizable()
                           .scaledToFit()
                           .frame(maxWidth: geometry.size.width * 0.6)
                           .padding(.top)

                       VStack(alignment: .leading) {
                           Rectangle()
                               .frame(height: 2)
                               .foregroundColor(.lightBackground)
                               .padding(.vertical)

                           Text("Mission Highlights")
                               .font(.title.bold())
                               .padding(.bottom, 5)

                           Text(mission.description)

                           Rectangle()
                               .frame(height: 2)
                               .foregroundColor(.lightBackground)
                               .padding(.vertical)

                           Text("Crew")
                               .font(.title.bold())
                               .padding(.bottom, 5)
                       }
                       .padding(.horizontal)

                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(crew, id: \.role) { crewMember in
                                   NavigationLink {
                                       AstronautsView(astronaut: crewMember.astronaut)
                                   } label: {
                                       HStack {
                                           Image(crewMember.astronaut.id)
                                               .resizable()
                                               .frame(width: 104, height: 72)
                                               .clipShape(Capsule())
                                               .overlay(
                                                   Capsule()
                                                       .strokeBorder(.white, lineWidth: 1)
                                               )

                                           VStack(alignment: .leading) {
                                               Text(crewMember.astronaut.name)
                                                   .foregroundColor(.white)
                                                   .font(.headline)

                                               Text(crewMember.role)
                                                   .foregroundColor(.secondary)
                                           }
                                       }
                                       .padding(.horizontal)
                                   }
                               }
                           }
                       }
                   }
                   .padding(.bottom)
               }
           }
           .navigationTitle(mission.displayName)
           .navigationBarTitleDisplayMode(.inline)
           .background(.darkBackground)
       }

       init(mission: MissionsModel, astronauts: [String: MoonShotModel]) {
           self.mission = mission

           self.crew = mission.crew.map { member in
               if let astronaut = astronauts[member.name] {
                   return CrewMember(role: member.role, astronaut: astronaut)
               } else {
                   fatalError("Missing \(member.name)")
               }
           }
       }
   }

   struct MissionView_Previews: PreviewProvider {
       static let missions: [MissionsModel] = Bundle.main.decode("missions.json")
       static let astronauts: [String: MoonShotModel] = Bundle.main.decode("astronauts.json")

       static var previews: some View {
           MissionsView(mission: missions[0], astronauts: astronauts)
               .preferredColorScheme(.dark)
       }
   }
