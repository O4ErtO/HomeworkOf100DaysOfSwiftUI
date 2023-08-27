//
//  File.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 27.08.2023.
//

import SwiftUI

class Order: ObservableObject{
    static let types = ["Strawberry", "Vanila", "Cherry", "Chocolate", "Rainbow"]
    
    
    @Published var type = 0
    @Published var quntity = 2
    
    
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
