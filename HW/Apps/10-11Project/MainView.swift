//
//  ContentView.swift
//  tenelvenProject
//
//  Created by Artem Vekshin on 22.09.2023.
//

import SwiftUI



struct MaintenView: View {
    
    @ObservedObject var users = UserViewModel()
    
    var body: some View {
        NavigationView {
            List(users.arrayOfUsers) {
                user in
                NavigationLink(destination: DetailUserView(user: user, users: users)) {
                    HStack {
                        VStack(alignment: .leading, spacing: nil) {
                            Text(user.name)
                                .font(.headline)
                            Text("Age: \(user.age)")
                        }
                   }
                }
            }
        .navigationBarTitle(Text("Users list"))
        }
    }
}


