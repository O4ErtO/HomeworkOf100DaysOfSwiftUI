//
//  WorkingWithUrlMoonShot.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 05.08.2023.
//

import Foundation
extension Bundle{
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
                   fatalError("Failed to locate \(file) in bundle.")
               }
        
        guard let data = try? Data(contentsOf: url) else {
        fatalError("Not data to decode \(file)")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let loaded = try?  decoder.decode(T.self, from: data) else{
            fatalError("Can't decode \(file)")
            
        }
        return loaded
    }
}
