//
//  ListView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/13/24.
//

import SwiftUI

struct ListView: View {
    let MyLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if MyLists.isEmpty {
                Spacer()
                
                Text("No reminders found")
            } else {
                ForEach(MyLists) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            ListCellView(myList: myList)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { myList in
                    MyListDetailView(myList: myList)
                        .navigationTitle(myList.name)
                }
            }
            
        }
    }
}

//#Preview {
//    ListView()
//}
