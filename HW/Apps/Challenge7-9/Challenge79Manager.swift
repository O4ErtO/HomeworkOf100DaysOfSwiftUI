//
//  ChallengeManager.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 18.08.2023.
//

import Foundation

struct Challenge79Manager: Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var counter: Int
}
