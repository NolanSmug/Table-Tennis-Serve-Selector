//
//  ServeManagerView.swift
//  Table Tennis Serve
//
//  Created by Nolan Cyr on 10/7/24.
//

import SwiftUI

struct ServeManagerView: View {
    @Binding var enabledServeTypes: Set<String>
    @Binding var enabledSpinTypes: Set<String>
    @State private var newServeType: String = ""
    @State private var newSpinType: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Serve Types")) {
                    ForEach(Array(enabledServeTypes), id: \.self) { type in
                        Text(type)
                    }
                    .onDelete(perform: deleteServeType)
                    
                    HStack {
                        Button(action: addServeType) {
                            Image(systemName: "plus")
                        }
                        TextField("New serve type", text: $newServeType)
                    }
                }
                
                Section(header: Text("Spin Types")) {
                    ForEach(Array(enabledSpinTypes), id: \.self) { type in
                        Text(type)
                    }
                    .onDelete(perform: deleteSpinType)
                    
                    HStack {
                        Button(action: addSpinType) {
                            Image(systemName: "plus")
                        }
                        TextField("New spin type", text: $newSpinType)
                    }
                }
            }
            .navigationBarTitle("Manage Types", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addServeType() {
        let trimmed = newServeType.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        enabledServeTypes.insert(trimmed)
        newServeType = ""
    }
    
    private func deleteServeType(at offsets: IndexSet) {
        let typesToRemove = offsets.map { Array(enabledServeTypes)[$0] }
        enabledServeTypes.subtract(typesToRemove)
    }
    
    private func addSpinType() {
        let trimmed = newSpinType.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        enabledSpinTypes.insert(trimmed)
        newSpinType = ""
    }
    
    private func deleteSpinType(at offsets: IndexSet) {
        let typesToRemove = offsets.map { Array(enabledSpinTypes)[$0] }
        enabledSpinTypes.subtract(typesToRemove)
    }
}

struct ServeManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
