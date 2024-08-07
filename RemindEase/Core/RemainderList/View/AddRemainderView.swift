//
//  AddRemainderView.swift
//  RemindEase
//
//  Created by MTPC-206 on 05/08/24.
//

import SwiftUI

struct AddRemainderView: View {
    
    @State var title = ""
    @State var desc = ""
    @State var selectedColor = Color.accentColor
    @State var date = Date.now
    @Environment(\.dismiss) var dismiss
    @State var users = [String]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter Title", text: $title)
                    TextField("Enter Description(Optional)", text: $desc,axis: .vertical)
                        .frame(maxHeight: 100)
                }
                .listRowBackground(Color.item)
                
                Section {
                    DatePicker(selection: $date, in: Date.now..., displayedComponents: [.date,.hourAndMinute]) {
                        Text("Date")
                    }
                    .background(Color.item)
                    .datePickerStyle(.compact) // or .compact or .graphical
                   
                    ColorPicker("Select Color", selection: $selectedColor)
                    
                    
                }
                .listRowBackground(Color.item)

            }
            .foregroundColor(.title)
            .background(Color.background)
            .scrollContentBackground(.hidden)
            .navigationTitle("Add Remainder")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close", role: .cancel) {
                        dismiss()
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    NavigationStack {
        AddRemainderView()
    }
}
