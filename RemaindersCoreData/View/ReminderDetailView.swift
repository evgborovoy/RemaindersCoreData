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
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // MARK: Title and Notes
                    Section {
                        TextField("Title", text: $editConfig.title)
                        
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                    
                    // MARK: Date, Time and List
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundStyle(editConfig.hasDate ? .green : .red)
                        }
                        
                        if editConfig.hasDate {
                            DatePicker("Select Date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundStyle(.blue)
                        }
                        
                        if editConfig.hasTime {
                            DatePicker("Select Time", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        
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
                    
                }
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
