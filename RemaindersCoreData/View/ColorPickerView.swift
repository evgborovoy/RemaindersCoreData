//
//  ColorPickerView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    
    let colors: [Color] = [
        .red, .blue, .green, .yellow, .purple, .orange
        ]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack{
                    Circle()
                        .fill()
                        .foregroundStyle(color)
                        .padding(2)
                    
                    Circle()
                        .strokeBorder(selectedColor == color ? .gray : .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                }
                .onTapGesture {
                    withAnimation {
                        selectedColor = color
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
}

#Preview {
    ColorPickerView(selectedColor: .constant(.blue))
}
