//
//  RemaindersCoreDataApp.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import SwiftUI
import UserNotifications

@main
struct RemaindersCoreDataApp: App {
    
    init () {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                // notification is granted
            } else {
                // display message to the user
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
