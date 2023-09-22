//
//  File.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 27.08.2023.
//

import SwiftUI

class Order: ObservableObject, Codable{
    
    enum CodingKeys: CodingKey{
        case type, quntity, extraFrosting, addSprinkles, streetAdressField, nameField, cityAdressField, zipField
    }
    
    
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
    
    
    
    @Published var streetAdressField = ""
    @Published var nameField = ""
    @Published var cityAdressField = ""
    @Published var zipField = ""
    
    
    
    
    var checkEmptyStrInAdressView: Bool{
        if streetAdressField.isEmpty || nameField.isEmpty || cityAdressField.isEmpty || zipField.isEmpty{
            return true
        }
        else{
            return false
        }
    }
    
    
    
    var cost: Double{
        var cost = Double(quntity) * 2
        
        cost += (Double(quntity) / 2)
        
        if extraFrosting{
            cost += Double(quntity)
        }
        if addSprinkles{
            cost += Double(quntity) / 2
        }
        return cost
    }
    
    init(){ }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quntity, forKey: .quntity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(streetAdressField, forKey: .streetAdressField)
        try container.encode(nameField, forKey: .nameField)
        try container.encode(cityAdressField, forKey: .cityAdressField)
        try container.encode(zipField, forKey: .zipField)
    }
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quntity = try container.decode(Int.self, forKey: .quntity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        nameField = try container.decode(String.self, forKey: .nameField)
        streetAdressField = try container.decode(String.self, forKey: .streetAdressField)
        streetAdressField = try container.decode(String.self, forKey: .cityAdressField)
        zipField = try container.decode(String.self, forKey: .zipField)
    }
}
