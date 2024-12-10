//
//  Activity.swift
//  DailyHabit
//
//  Created by Aaron Medina on 11/22/24.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    let name: String
    let streak: Int
}

@Observable
class Activities {
    var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decoded
                return
            }
        }
        
        activities = []
    }
    
    
}
