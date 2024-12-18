//
//  AddNewListView.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/12/24.
//

import SwiftUI

struct AddNewListView: View {
    // MARK: - Properties
    @State private var name = ""
    @State private var selectedColor = Color.yellow
    @Environment(\.dismiss) private var dismiss
    
    let onSave: (String, UIColor) -> Void
    
    private var isValidForm: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(selectedColor)
                
                // MARK: New list TextField
                TextField("List name", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            // MARK: Color picker
            ColorPickerView(selectedColor: $selectedColor)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New List")
                    .font(.headline)
            }
            // MARK: Close button
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            // MARK: Done button
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    onSave(name, UIColor(selectedColor))
                    dismiss()
                }
                .disabled(!isValidForm)
            }
            
        }
    }
}

#Preview {
    NavigationView {
        AddNewListView(onSave: { (_, _) in })
        
    }
}
