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
            ZStack {
                if activities.activities.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "calendar.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.blue.opacity(0.7))
                            .padding()
                            .background(
                                Circle()
                                    .fill(.blue.opacity(0.1))
                                    .frame(width: 160, height: 160)
                            )
                        
                        Text("No Habits Yet")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Tap the + button to start tracking your daily habits")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(activities.activities) { activity in
                            NavigationLink(destination: DetailView(activity: activity, activities: activities)) {
                                HStack(spacing: 16) {
                                    Circle()
                                        .fill(streakColor(for: activity.streak))
                                        .frame(width: 40, height: 40)
                                        .overlay {
                                            Text("\(activity.streak)")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(activity.name)
                                            .font(.headline)
                                        
                                        Text("Active streak: \(activity.streak) days")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                AddActivityView(activities: activities)
            }
        }
    }
    
    private func streakColor(for streak: Int) -> Color {
        switch streak {
        case 0...7:
            return .blue
        case 8...14:
            return .green
        case 15...30:
            return .purple
        default:
            return .orange
        }
    }
    
    func delete(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
