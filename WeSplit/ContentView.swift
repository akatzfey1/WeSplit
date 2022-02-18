//
//  ContentView.swift
//  WeSplit
//
//  Created by Alexander Katzfey on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double? = nil
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var tipTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount ?? 0.0) / 100 * tipSelection
        return tipValue
    }

    var grandTotal: Double {
        let grandTotal = (checkAmount ?? 0.0) + tipTotal
        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let totalPerPerson = grandTotal / peopleCount
        return totalPerPerson
    }
    
    var currencyStyle: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyStyle)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people" , selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                Section {
                    Text(tipTotal, format: currencyStyle)
                } header: {
                    Text("Tip Total:")
                }
                
                Section {
                    Text(grandTotal, format: currencyStyle)
                } header: {
                    Text("Grand Total:")
                }

                Section {
                    Text(totalPerPerson, format: currencyStyle)
                } header: {
                    Text("Total per person:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack { //Fix for Apple's @FocusState in top level view bug
            ContentView()
        }
    }
}
