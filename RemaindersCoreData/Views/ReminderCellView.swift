//
//  ReminderCellView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder, Bool)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    @State private var checked: Bool = false
    
    let reminder: Reminder
    let isSelected: Bool
    let onEvent: (ReminderCellEvents) -> Void
    let delay = Delay()
    
    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.5)
                .onTapGesture {
                    checked.toggle()
                    
                    delay.cancel()
                    
                    delay.performWork {
                        onEvent(.onCheckedChange(reminder, checked))
                    }
                }
            
            VStack(alignment: .leading) {
                // MARK: Title
                Text(reminder.title ?? "")
                    .font(.headline)
                
                // MARK: Notes
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .opacity(0.5)
                }
                
                HStack {
                    // MARK: Date
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    // MARK: Time
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.5)
            }
            
            Spacer()
            
            // MARK: Info Button
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1 : 0)
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .onAppear {
            checked = reminder.isCompleted
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder,isSelected: false, onEvent: { _ in })
}
