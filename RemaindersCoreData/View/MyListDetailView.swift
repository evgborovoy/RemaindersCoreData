//
//  MyListDetailView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/15/24.
//

import SwiftUI

struct MyListDetailView: View {
    @State private var openAddReminder = false
    @State private var title = ""
    
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    
    let myList: MyList
    
    private var isFormValid: Bool {
        !title.isEmpty
    }
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack {
            ReminderListView(reminders: reminderResults)
            HStack {
                Spacer()
                
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                if isFormValid {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
