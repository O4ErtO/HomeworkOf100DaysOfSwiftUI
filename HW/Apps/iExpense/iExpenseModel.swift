//
//  iExpenseModel.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 04.08.2023.
//

import Foundation
struct iExpensesModel: Identifiable, Codable{
    var id = UUID()
    let name : String
    let amount: Int
    let type: String
}
