//
//  CornerOrderMainView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 27.08.2023.
//

import SwiftUI

struct CornerOrderMainView: View {
    @ObservedObject var order : Order
    var body: some View {
        NavigationView{
            Form {
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }.pickerStyle(.menu)
                    Stepper("Number of cakes: \(order.quntity)", value: $order.quntity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                    Section{
                        NavigationLink{
                            AdressView(viewModel: Order())
                        }label: {
                            Text("Continue")
                        }
                    }
                }
            }
        }.navigationTitle("Cupcacke order")
    }
}

