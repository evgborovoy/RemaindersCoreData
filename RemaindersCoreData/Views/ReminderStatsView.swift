//
//  ReminderStatsView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/18/24.
//

import SwiftUI

struct ReminderStatsView: View {
    let icon: String
    let title: String
    var count: Int?
    var iconColor: Color = .blue
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundStyle(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.2))
            .foregroundStyle(.text)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 9)
}
