//
//  DetailUserView.swift
//  tenelvenProject
//
//  Created by Artem Vekshin on 22.09.2023.
//

import SwiftUI

struct DetailUserView: View {
    var user: MainModel
    var users: UserViewModel
    @State private var isShowing = false
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                Text(user.name)
            }
            Section(header: Text("Age")) {
                Text("\(user.age)")
            }
            Section(header: Text("Company")){
                Text("\(user.company)🏢")
            }
            Section(header: Text("Swipe to show a friends")){
                Toggle(isOn: $isShowing){
                    Text("Show \(user.name) frind")
                }
                
            }
            
            if isShowing{
                NavigationLink(destination: FriendsListView(users: self.users, user: self.user)){
                    Text("Show \(user.name)'s friends")
                }
                }
            }
        }
    }

