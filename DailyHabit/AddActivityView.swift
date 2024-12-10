//
//  AddActivityView.swift
//  DailyHabit
//
//  Created by Aaron Medina on 12/8/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var activityName = ""
    @State private var streakLength = 0
    @State private var activityDescription = ""
    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Activity Name", text: $activityName)
                }
                
                Section(header: Text("Description")) {
                    TextField("Optional", text: $activityDescription)
                }
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let activity = Activity(name: activityName, streak: streakLength)
                        activities.activities.append(activity)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
