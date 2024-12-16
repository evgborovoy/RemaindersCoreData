//
//  ReminderCellView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import SwiftUI

enum ReminderCellEvents {
    case onInfo
    case onCheckedChange(Reminder)
    case onSelect(Reminder)
}

struct ReminderCellView: View {
    @State private var checked: Bool = false
    
    let reminder: Reminder
    let onEvent: (ReminderCellEvents) -> Void
    
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
                    onEvent(.onCheckedChange(reminder))
                }
            
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                    .font(.headline)
                
                if let notes = reminder.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .opacity(0.5)
                }
                
                HStack {
                    if let reminderDate = reminder.reminderDate {
                        Text(formatDate(reminderDate))
                    }
                    
                    if let reminderTime = reminder.reminderTime {
                        Text(reminderTime.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.5)
            }
            
            Spacer()
            Image(systemName: "info.circle.fill")
                .onTapGesture {
                    onEvent(.onInfo)
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }
}

#Preview {
    ReminderCellView(reminder: PreviewData.reminder, onEvent: { _ in })
}
