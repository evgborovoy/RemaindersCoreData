//
//  SelectListView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import SwiftUI

struct SelectListView: View {
    
    // MARK: - Properties
    @FetchRequest(sortDescriptors: [])
    private var myListsFetchResults: FetchedResults<MyList>
    
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myListsFetchResults) { myList in
            HStack {
                
                HStack {
                    // MARK: Image
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(myList.color))
                    
                    // MARK: List title
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = myList
                }
                
                // MARK: Checkmark
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    SelectListView(selectedList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
