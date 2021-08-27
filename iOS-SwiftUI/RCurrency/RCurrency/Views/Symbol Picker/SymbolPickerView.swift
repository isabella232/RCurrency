//
//  SymbolPickerView.swift
//  SymbolPickerView
//
//  Created by Andrew Morgan on 27/08/2021.
//

import SwiftUI

struct SymbolPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedSymbol: String
    
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(searchResults.sorted(by: <), id: \.key) { symbol in
                Button(action: {
                    selectedSymbol = symbol.key
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(symbol.key.lowercased())
                        Text("\(symbol.key): \(symbol.value)")
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationBarTitle("Pick Currency", displayMode: .inline)
    }
    
    var searchResults: Dictionary<String, String> {
        if searchText.isEmpty {
            return Symbols.data.symbols
        } else {
            return Symbols.data.symbols.filter {
                $0.key.contains(searchText.uppercased()) || $0.value.contains(searchText)}
        }
    }
}

struct SymbolPickerView_Previews: PreviewProvider {
    static var previews: some View {
        Symbols.loadData()
        return NavigationView {
            SymbolPickerView(selectedSymbol: .constant("GBP"))
        }
    }
}
