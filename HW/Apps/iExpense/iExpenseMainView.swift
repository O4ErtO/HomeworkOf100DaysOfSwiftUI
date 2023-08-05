//
//  iExpenseMainView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 04.08.2023.
//

import SwiftUI

struct iExpenseMainView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddViewExpense = false
    var body: some View {
        VStack{
            List{
                ForEach(expenses.item){
                    item in
                    HStack {
                          VStack(alignment: .leading) {
                              Text(item.name)
                                  .font(.headline)
                              Text(item.type)
                          }

                          Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                            .tint(item.amount < 10 ? .green : (item.amount < 100 ? .orange : .red))
                      }
                }.onDelete(perform: removeItems)
            }.toolbar {
                Button {
                   showingAddViewExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        }.sheet(isPresented: $showingAddViewExpense) {
            IExpenseExtendedView(expenses: expenses)
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        expenses.item.remove(atOffsets: offsets)
    }
}

#Preview {
    iExpenseMainView()
}
