//
//  ChallengeMainView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 18.08.2023.
//

import SwiftUI


struct ListHobbies: View {
    @EnvironmentObject var hobbiesModel: Challenge79Model
    @State private var showDetailView = false
    var body: some View {
        NavigationView{
            ZStack{
              Text("Push on the 'plus' to add your hobbies")
                    
                    .font(.title)
                    .opacity(0.6)
                    .multilineTextAlignment(.center)
                List{
                    ForEach(hobbiesModel.hobbies){ hobby in
                        NavigationLink(destination: HobbiesDetailView(hobby: hobby)){
                            Text(hobby.title)
                        }
                    }.onDelete{ indexSet in
                        hobbiesModel.hobbies.remove(atOffsets: indexSet)
                        hobbiesModel.saveHobbies()
                    }
                }
            }
            
        }
        .navigationBarItems(trailing:
                                Button{
            showDetailView = true
            
        }label: {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $showDetailView) {
            AddHobbiesView(hobbyModel: _hobbiesModel, showDetailView: $showDetailView)
        }
    }
}


struct HobbiesDetailView: View {
    @EnvironmentObject var hobbiesModel: Challenge79Model
    var hobby: Challenge79Manager
    var body: some View {
        VStack{
            Text(hobby.description)
            Text("I do this : \(hobby.counter) times")
            Button("I do this thing!") {
                          hobbiesModel.Counter(for: hobby)
                      }
                      .padding()
                      .foregroundColor(.white)
                      .background(Color.cyan)
                      .cornerRadius(10)
        }.navigationTitle(hobby.title)
    }
    

}
struct AddHobbiesView: View {
    @EnvironmentObject var hobbyModel: Challenge79Model
    @Binding var showDetailView: Bool
    @State private var title = ""
    @State private var descriprtion = ""
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Hobbies details")){
                    TextField("Title", text: $title)
                    TextField("Description", text: $descriprtion)
                }
            }.navigationTitle("Add hobby")
                .navigationBarItems(trailing: Button("Save"){
                    if title.count >= 3{
                        hobbyModel.addHobbies(title: title, description: descriprtion)
                        showDetailView = false
                    }
            })
        }
           
    } 
       
}


