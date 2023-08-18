//
//  IExpenseExtendedView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 04.08.2023.
//

import SwiftUI

struct IExpenseExtendedView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var amount = 0
    @State private var type = "Personal"
    @Environment(\.dismiss) var dismiss
  let types = ["Private", "Buisness"]
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self ){
                        Text($0)
                    }
                }
                
                
                TextField("amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .toolbar {
                Button("Save") {
                    let item = iExpensesModel(name: name, amount: amount, type: type)
                    expenses.item.append(item)
                    dismiss()
                }
            }
            .navigationTitle("Add new expense")
        }
    }
}


   
struct IExpenseExtendedView_Previews: PreviewProvider {
    static var previews: some View {
        IExpenseExtendedView(expenses: Expenses())
    }
}
