
import Foundation
import SwiftUI
struct MainModel: Codable, Identifiable{
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var friends: [Friend]
    
}
struct Friend: Codable, Identifiable{
    var id: String
    var name: String
}
