//
//  Challenge79Model.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 18.08.2023.
//

import Foundation

class Challenge79Model: ObservableObject{
    @Published var hobbies: [Challenge79Manager] = []
    
    init(){
        loadHobbies()
    }

    func addHobbies(title: String, description: String){
        let hobby = Challenge79Manager(title: title, description: description, counter: 0)
        hobbies.append(hobby)
        saveHobbies()
        
    }
    
    func Counter(for hobby: Challenge79Manager){
        if let index = hobbies.firstIndex(where: {$0.id == hobby.id}){
            hobbies[index].counter += 1
            saveHobbies()
        }
    }
    private func loadHobbies() {
           if let data = UserDefaults.standard.data(forKey: "habits") {
               let decoder = JSONDecoder()
               if let decodedData = try? decoder.decode([Challenge79Manager].self, from: data) {
                   hobbies = decodedData
                   return
               }
           }
           hobbies = []
       }
     func saveHobbies() {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(hobbies) {
                UserDefaults.standard.set(encodedData, forKey: "habits")
            }
        }
    

    
    
}
