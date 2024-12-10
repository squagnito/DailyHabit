//
//  ContentView.swift
//  DailyHabit
//
//  Created by Aaron Medina on 11/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.activities) { activity in
                    HStack {
                        Text(activity.name)
                        Text("Active streak: \(activity.streak)")
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Habits")
            .toolbar {
                NavigationLink("Add Activity", destination: AddActivityView(activities: activities))
            }
        }
    }
    
    
    func delete(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
