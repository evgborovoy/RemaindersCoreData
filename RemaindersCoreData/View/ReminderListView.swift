//
//  ReminderListView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import SwiftUI

struct ReminderListView: View {
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail = false
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged (reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig (reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            let _ = try ReminderService.updateReminder (reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isSelectedReminder (_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder (_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isSelectedReminder(reminder)) { event in
                        switch event {
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                        case .onCheckedChange(let reminder, let isCompleted):
                            reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                        case.onInfo:
                            showReminderDetail = true
                        }
                    }
                }
                .onDelete(perform: deleteReminder)
            }
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}

//#Preview {
//    ReminderListView()
//}
