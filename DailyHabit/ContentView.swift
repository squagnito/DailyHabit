//
//  ContentView.swift
//  DailyHabit
//
//  Created by Aaron Medina on 11/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            if activities.activities.isEmpty {
                Text("Your streaks will appear here")
                    .frame(maxHeight: .infinity)
            }
            
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink(destination: DetailView(activity: activity, activities: activities)) {
                        HStack {
                            Text(activity.name)
                            Text("Active streak: \(activity.streak)")
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Habits")
            .toolbar {
                Button("Add Activity") {
                    showingSheet.toggle()
                }
            }
            .sheet(isPresented: $showingSheet) {
                AddActivityView(activities: activities)
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
