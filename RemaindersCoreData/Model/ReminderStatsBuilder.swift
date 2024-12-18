//
//  ReminderStatsBuilder.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/17/24.
//

import SwiftUI

enum ReminderStatType {
    case today
    case scheduled
    case completed
    case all
}

struct ReminderStatsValues {
    var todayCount = 0
    var scheduledCount = 0
    var completedCount = 0
    var allCount = 0
}

struct ReminderStatsBuilder {
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        let remindersArray = myListResults.map { $0.remindersArray}.reduce([], +)
        
        let allCount = calculateAllCount(reminders: remindersArray)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let todayCount = calculateTodayCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        
        return ReminderStatsValues(todayCount: todayCount, scheduledCount: scheduledCount, completedCount: completedCount, allCount: allCount)
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateTodayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil)
                    && !reminder.isCompleted) ? result + 1 : result
        }
    }
}
