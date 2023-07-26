//
//  ContentView.swift
//  WeSplit
//
//  Created by Artem Vekshin on 18.07.2023.
//

import SwiftUI

struct ContentView: View {
    let  sveta:FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    @State private var aomuntWithoutTip = false
    @State private var aomuntWithTip = true
    @State private var sum = 0.0
    @State private var people = 0
    @State private var selctTip = 20
    @State private var tip = [10, 20, 25, 50, 0]
    @FocusState private var keyboardOpen: Bool
    var body: some View {
        var totalPriceForOnePersone: Double{
            let cpeople = Double(people + 2)
            let ctip = Double(selctTip)
            
            
            let tipValue = sum / 100 * ctip
            let grandSum = sum + tipValue
            let totalFroPerson = grandSum / cpeople
            
            return totalFroPerson
        }
        
        
        
        
        
        NavigationView{
            Form{
                Section{
                    TextField("Amount",value: $sum, format: sveta)
                        .focused($keyboardOpen)
                    
                } .keyboardType(.decimalPad)
                
                Section{
                    Picker("How much person?", selection: $people) {
                        ForEach(2..<20){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                    
                }
                Section{
                    Picker("Tip", selection: $selctTip) {
                        ForEach(tip, id: \.self){
                            Text($0, format: .percent)
                            
                        }
                    
                    } .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Choise tip")
                }
                
                
                
                Section{
                    Text(totalPriceForOnePersone, format: sveta)
                } header: {
                    Text("total amount on the person wit tip")
                }
                
                
                Section{
                    let cppeople = Double(people + 2)
                    let foronepeople = (sum / cppeople)
                    Text(foronepeople, format: sveta)
                }header: {
                    Text("total amount on the person without tip")
                        .foregroundColor(selctTip == 0 ? .red : .gray)
                }
                
                
                Section{
                    
                    let totalTip = Double(selctTip)
                    let allSumNotSplit = (sum / 100 * totalTip) + sum
                    
                    Text(allSumNotSplit ,format: sveta )
                } header: {
                    Text("Total aomunt with tip")
                        .foregroundColor(selctTip != 0 ? .green : .gray)
                    
                }
            }.navigationTitle("AV")
        }
        
        .toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done"){
                    keyboardOpen = false
                }
            }
        }
        
    }
    }


#Preview {
    ContentView()
}
