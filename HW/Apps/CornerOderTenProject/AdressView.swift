//
//  AdressView.swift
//  OnehundredDayOfSwift
//
//  Created by Artem Vekshin on 11.09.2023.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var viewModel : Order
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter your street", text: $viewModel.streetAdressField)
                    TextField("Enter your name", text: $viewModel.nameField)
                    TextField("Enter your city" , text: $viewModel.cityAdressField)
                    TextField("Enter your ZIP", text: $viewModel.zipField)
                }
                Section{
                    NavigationLink("CheckOut") {
                        CheckOutView(viewModel: Order())
                    }.disabled(viewModel.checkEmptyStrInAdressView)
                }
            }
        }
    }
}

#Preview {
    AdressView(viewModel: Order())
}
