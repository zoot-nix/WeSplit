//
//  ContentView.swift
//  Shared
//
//  Created by Owais Shaikh on 26/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var totalBill = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountisFocused: Bool //To hide keyboard
    
    var totalPerPerson: Double{
        // Calculation
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = totalBill / 100 * tipSelection
        let totalAmount = totalBill + tipValue
        let totalAmountPerPerson = totalAmount / peopleCount
        
        return totalAmountPerPerson
    }
    
    var totalBillAmount: Double{
        let tipSelection = Double(tipPercentage)
        
        let tipValue = totalBill / 100 * tipSelection
        let totalAmount = totalBill + tipValue
        
        return totalAmount
    }
    
    let tipPercentOption = [0, 10, 15, 20, 25, 30]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    
                    TextField("Amount", value: $totalBill, format: .currency(code: "INR")) //Convert text to currency
                        .keyboardType(.decimalPad) //NumericKeyboard
                        .focused($amountisFocused) //To hide keyboard
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Tip Percentage")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentOption, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented) //Change Picker Style
                }
                
                
                Section(header: Text("Total amount after added tip")){
                    Text(totalBillAmount, format: .currency(code: "INR"))
                        .background(tipPercentage == 0 ? Color.red : Color.white) //EDIT : Tip = 0% BgColor Red

                }
                
                Section(header: Text("Total Per Person")){
                    Text(totalPerPerson, format: .currency(code: "INR"))
                }
            }
            .navigationTitle("weSplit")
            
            .toolbar{ //Done Button for Keyboard
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountisFocused = false
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
