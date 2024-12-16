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
    
    @State private var isPresented = false
    var body: some View {
        NavigationStack {
            VStack {
                
                ListView(MyLists: myListResults)
                
                Button{
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }
                .padding()
            }.sheet(isPresented: $isPresented) {
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
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
