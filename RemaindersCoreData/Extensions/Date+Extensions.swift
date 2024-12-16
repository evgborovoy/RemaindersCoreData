//
//  Date+Extensions.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
