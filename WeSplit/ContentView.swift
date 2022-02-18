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
    @State private var tipPercentage = 18
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10,  15, 18, 20, 25]
    
    var totalPerPerson: Double {
        // Calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount ?? 0.0) / 100 * tipSelection
        let grandTotal = (checkAmount ?? 0.0) + tipValue
        let totalPerPerson = grandTotal / peopleCount
        
        return totalPerPerson
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                        .currency(code: Locale.current.currencyCode ?? "USD"))
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
                        ForEach(tipPercentages, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip amount:")
                }
                
                Section {
                    Text(totalPerPerson, format:
                        .currency(code: Locale.current.currencyCode ?? "USD"))
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
        ContentView()
    }
}
