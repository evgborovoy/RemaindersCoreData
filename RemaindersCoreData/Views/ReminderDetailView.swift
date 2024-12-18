//
//  ReminderDetailView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import SwiftUI

struct ReminderDetailView: View {
    @State private var editConfig: ReminderEditConfig = ReminderEditConfig()
    @Binding var reminder: Reminder
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // MARK: Title and Notes
                    Section {
                        TextField("Title", text: $editConfig.title)
                        
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(editConfig.hasDate ? .green : .red)
                        }
                        // MARK: Date
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        // MARK: Time
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
                        // MARK: List
                        Section {
                            NavigationLink {
                                SelectListView(selectedList: $reminder.list )
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list?.name ?? "Choose List")
                                }
                            }
                        }
                    }
                    .onChange(of: editConfig.hasDate) {
                        if editConfig.hasDate {
                            editConfig.reminderDate = Date()
                        }
                    }
                    .onChange(of: editConfig.hasTime) {
                        if editConfig.hasTime {
                            editConfig.reminderTime = Date()
                        }
                    }
                }
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                
                // MARK: Cancel Button
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                // MARK: Done Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        do {
                            let _ = try ReminderService.updateReminder(
                                reminder: reminder,
                                editConfig: editConfig
                            )
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
