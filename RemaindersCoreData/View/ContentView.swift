//
//  ContentView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @FetchRequest(sortDescriptors: [])
    private var searchResults: FetchedResults<Reminder>
    
    @State private var isPresented = false
    @State private var search = ""
    @State private var searching = false
    
    var body: some View {
        NavigationStack {
                VStack {
                    ScrollView {
                    myListView(MyLists: myListResults)
                    
                    Button{
                        isPresented = true
                    } label: {
                        Text("Add List")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .onChange(of: search) {
                searching = !search.isEmpty ? true : false
                searchResults.nsPredicate = ReminderService.getRemindersBySearch(search).predicate
            }
            .overlay(alignment: .center) {
                        ReminderListView(reminders: searchResults)
                            .opacity(searching ? 1 : 0)
            }
            .padding()
            .navigationTitle("Reminders")
        }
        .searchable(text: $search)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
