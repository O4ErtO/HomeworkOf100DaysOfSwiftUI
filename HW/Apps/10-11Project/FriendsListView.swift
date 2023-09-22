//
//  FriendsListView.swift
//  tenelvenProject
//
//  Created by Artem Vekshin on 22.09.2023.
//

import SwiftUI

struct FriendsListView: View {
    var users: UserViewModel
    var user: MainModel
       
       var body: some View {
           List(user.friends) {
               friend in
               NavigationLink(destination: DetailUserView(user: self.users.findUser(string: friend.id), users: self.users)) {
                   VStack(alignment: .leading, spacing: nil) {
                       Text(friend.name)
                   }
               }
           }.navigationBarTitle("\(self.user.name)'s friends", displayMode: .inline)
       }
   }



