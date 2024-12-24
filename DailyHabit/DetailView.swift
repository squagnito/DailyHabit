//
//  DetailView.swift
//  DailyHabit
//
//  Created by Aaron Medina on 12/11/24.
//

import SwiftUI

struct DetailView: View {
    var activity: Activity
    var activities: Activities
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(activity.description)
            Text("Active streak: \(activity.streak) days")
            
            Spacer()
            
            Button {
                incrementStreak()
            } label: {
                Text("Increment streak")
            }

        }
        .navigationTitle(activity.name)
    }
    
    func incrementStreak() {
        if let index = activities.activities.firstIndex(of: activity) {
            activities.activities[index].streak += 1
        }
    }
}

#Preview {
    DetailView(activity: Activity(name: "Run one mile",
                                  description: "Sample description",
                                  streak: 6,
                                  frequency: "Daily",
                                  icon: "figure.walk",
                                  codableColor: CodableColor(color: .blue)),
               activities: Activities())
}
