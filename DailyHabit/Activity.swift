//
//  Activity.swift
//  DailyHabit
//
//  Created by Aaron Medina on 11/22/24.
//

import SwiftUI

struct Activity: Identifiable, Codable, Hashable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var streak: Int
    var frequency: String
    var icon: String
    var codableColor: CodableColor
    var color: Color {  // Computed variable
        Color(red: codableColor.red,
              green: codableColor.green,
              blue: codableColor.blue,
              opacity: codableColor.opacity)
    }
}

// Struct for a codable color
struct CodableColor: Codable, Equatable, Hashable {
    var red = 0.0, green = 0.0, blue = 0.0, opacity = 0.0
    
    init(color: Color) {
            let uiColor = UIColor(color)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            self.red = Double(red)
            self.green = Double(green)
            self.blue = Double(blue)
            self.opacity = Double(alpha)
        }
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
