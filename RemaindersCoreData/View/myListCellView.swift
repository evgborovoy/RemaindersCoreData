//
//  myListCellView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/13/24.
//

import SwiftUI

struct myListCellView: View {
    let myList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundStyle(Color(myList.color))
            
            Text(myList.name)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray.opacity(0.4))
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    myListCellView(myList: PreviewData.myList)
}
