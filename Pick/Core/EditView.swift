//
//  EditView.swift
//  Pick
//
//  Created by Om Preetham Bandi on 7/30/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var picks: String
    
    var body: some View {
        NavigationView {
            List {
                TextField("Enter Number of Picks", text: $picks)
                    .font(.title)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Pick Count")
            .toolbar {
                Button("Done", systemImage: "checkmark") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditView(picks: .constant("0"))
}
