//
//  Expenses.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 04.08.2023.
//

import Foundation

class Expenses: ObservableObject{
    @Published var item = [iExpensesModel](){
        didSet {
            if let encoded = try? JSONEncoder().encode(item) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([iExpensesModel].self, from: savedItems) {
                item = decodedItems
                return
            }
        }

        item = []
    }
}
