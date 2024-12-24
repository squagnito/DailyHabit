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
    @State private var selectedFrequency = "Daily"
    @State private var selectedIcon = "star.fill"
    @State private var selectedColor = Color.blue
    
    var activities: Activities
    
    let frequencies = ["Daily", "Weekly", "Monthly"]
    let icons = ["star.fill", "heart.fill", "flame.fill", "drop.fill", "leaf.fill",
                 "book.fill", "figure.walk", "dumbbell.fill", "brain.head.profile"]
    let colors: [Color] = [.blue, .purple, .green, .orange, .red, .indigo]
    
    var isFormValid: Bool {
        !activityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: selectedIcon)
                            .font(.title)
                            .foregroundStyle(selectedColor)
                            .frame(width: 40, height: 40)
                            .background(selectedColor.opacity(0.2))
                            .clipShape(Circle())
                        
                        TextField("Habit Name", text: $activityName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.vertical, 8)
                }
                
                Section {
                    TextField("Description", text: $activityDescription)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 100, alignment: .top)
                        .lineLimit(5...)
                }
                
                Section(header: Text("Customize").textCase(.uppercase)) {
                    Picker("Frequency", selection: $selectedFrequency) {
                        ForEach(frequencies, id: \.self) { frequency in
                            Text(frequency).tag(frequency)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Choose an icon")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(icons, id: \.self) { icon in
                                    Image(systemName: icon)
                                        .font(.title2)
                                        .foregroundStyle(selectedIcon == icon ? selectedColor : .gray)
                                        .frame(width: 44, height: 44)
                                        .background(selectedIcon == icon ? selectedColor.opacity(0.2) : Color.gray.opacity(0.1))
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            withAnimation(.spring(response: 0.3)) {
                                                selectedIcon = icon
                                            }
                                        }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Pick a color")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        HStack(spacing: 16) {
                            ForEach(colors, id: \.self) { color in
                                Circle()
                                    .fill(color)
                                    .frame(width: 44, height: 44)
                                    .overlay(Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                        .opacity(selectedColor == color ? 1 : 0))
                                    .shadow(color: color.opacity(0.3), radius: 3)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3)) {
                                            selectedColor = color
                                        }
                                    }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let activity = Activity(name: activityName,
                                                description: activityDescription,
                                                streak: streakLength,
                                                frequency: selectedFrequency,
                                                icon: selectedIcon,
                                                codableColor: CodableColor(color: selectedColor))
                        activities.activities.append(activity)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
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
