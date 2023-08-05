//
//  kkoo.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 05.08.2023.
//

import SwiftUI

struct ExpenseView: View {
    let expenseType: String
    
    var body: some View {
        VStack {
            if expenseType == "Личные расходы" {
                Text("Личные расходы")
                    .font(.title)
                    .padding()
                // Поместите элементы для личных расходов в эту колонку

            } else {
                Text("Деловые расходы")
                    .font(.title)
                    .padding()
                // Поместите элементы для деловых расходов в эту колонку

            }
            
            // Общие элементы, отображаемые в обеих случаях
            Text("Это общее содержимое")
                .font(.headline)
        }
    }
}

struct ContentVieiw: View {
    var body: some View {
        VStack {
            ExpenseView(expenseType: "Личные расходы")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.yellow)
            
            ExpenseView(expenseType: "Деловые расходы")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
        }
    }
}


#Preview {
    ContentVieiw()
}
