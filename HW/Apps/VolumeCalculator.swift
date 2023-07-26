//
//  VolumeCalculator.swift
//  WeSplit
//
//  Created by Artem Vekshin on 18.07.2023.
//

import SwiftUI




enum Volume: String, CaseIterable {
    case milliliters = "milliliters"
    case liters = "liters"
    case cups = "cups"
    case gallons = "gallons"
}
struct VolumeCalculator: View {
    @State private var volume = 0
    @State private var outVolume = 0
    @State private var selectVolumes: Volume = .milliliters
    @State private var  outputVolumes: Volume = .liters
    
    var body: some View {
        
        NavigationView{
            
            
            Form {
                Section {
                    TextField("Enter Volume", value: $volume, format: .number)
                    
                    Picker("choise ur volume", selection: $selectVolumes) {
                        ForEach(Volume.allCases, id: \.self) { name in
                            Text(name.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectVolumes) {newValue in
                            convertVolumes()
                        }
                }
                Section {
                    
                    Text("\(outVolume, format: .number) \(outputVolumes.rawValue)")
                    
                    Picker("choise ur volume", selection: $outputVolumes) {
                        ForEach(Volume.allCases, id: \.self) { name in
                            Text(name.rawValue)
                        }
                        
                        
                    }.pickerStyle(SegmentedPickerStyle())
                        .onChange(of: outputVolumes) {newValue in
                            convertVolumes()
                        }
                    
                }
                
            }.navigationTitle("Calculate ur volume")
        }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Готово") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        convertVolumes()
                    }
                }
            }
        
    }
    private func convertVolumes(){
        var volumesTe: Int
        switch selectVolumes{
        case .milliliters:
            volumesTe = volume
        case .liters:
            volumesTe = volume * 1000
        case .gallons:
            volumesTe = volume * 4546
        case .cups:
            volumesTe = volume * 300
            
        }
        
        switch outputVolumes {
        case .milliliters:
            outVolume = volumesTe
        case .liters:
            outVolume  = volumesTe / 1000
        case .cups:
            outVolume = volumesTe / 300
        case .gallons:
            outVolume = volumesTe / 4546
        }
        
        
        
        
    }
}

#Preview {
    VolumeCalculator()
    
}

