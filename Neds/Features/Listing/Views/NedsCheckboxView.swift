//
//  NedsCheckboxView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 21/12/24.
//

import SwiftUI

//class NedsRaceTypeSelectionArray: ObservableObject, Equatable {
//    
//    @Published var raceTypeSelections: [NedsRaceTypeSelection]
//
//    init(raceTypeSelections: [NedsRaceTypeSelection]) {
//        self.raceTypeSelections = raceTypeSelections
//    }
//    
//    func getSelectedRaceTypes() -> [NedsRaceType] {
//        raceTypeSelections
//            .filter { $0.isSelected }
//            .map{ $0.raceType }
//    }
//    
//    static func == (lhs: NedsRaceTypeSelectionArray, rhs: NedsRaceTypeSelectionArray) -> Bool {
//        lhs.raceTypeSelections == rhs.raceTypeSelections
//    }
//}

@Observable class NedsRaceTypeSelection: Equatable {
    
    let raceType: NedsRaceType
    
    var isSelected: Bool
    
    init(raceType: NedsRaceType, isSelected: Bool) {
        self.raceType = raceType
        self.isSelected = isSelected
    }
    
    static func == (lhs: NedsRaceTypeSelection, rhs: NedsRaceTypeSelection) -> Bool {
        lhs.raceType == rhs.raceType
    }
}

enum NedsRaceType: String {
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case horse = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    
    var icon: String {
        switch self {
        case .greyhound:
            return "greyhound_racing"
        case .harness:
            return "harness_racing"
        case .horse:
            return "horse_racing"
        }
    }
    
    var defaultSelection: Bool {
        return true
    }
}

struct NedsCheckboxView: View {
    
    @Bindable var raceTypeSelection: NedsRaceTypeSelection
    
    func toggle() {
        raceTypeSelection.isSelected.toggle()
    }
    
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: raceTypeSelection.isSelected ? "checkmark.square": "square")
                    .tint(raceTypeSelection.isSelected ? AppColors.primarySelectionColor :
                            AppColors.primaryDeselectionColor)
                Image(raceTypeSelection.raceType.icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            .clipped()
        }
    }
}

#Preview {
    struct Preview: View {
        
        @State var raceTypeSelections: NedsRaceTypeSelection = NedsRaceTypeSelection(raceType: .horse,
                                                                                    isSelected: true)
        
        var body: some View {
            NedsCheckboxView(raceTypeSelection: raceTypeSelections)
        }
    }
    
    return Preview()
}
