//
//  AppColors.swift
//  Neds
//
//  Created by Sachithra Udayanga on 21/12/24.
//

import Foundation
import SwiftUI

enum AppColors {
    
    enum Text {
        static let primaryTextColor = Color("primary_text_color")
        static let secondaryTextColor = Color("secondary_text_color")
    }
    
    enum Button {
        static let primaryBackgroundColor = Color("primary_background_color")
        static let primaryForegroundColor = Color("primary_foreground_color")
    }
    
    enum Checkbox {
        static let selection = Color("primary_selection_color")
        static let deselection = Color("primary_deselection_color")
        static let selectionTint = Color("primary_selection_tint_color")
        static let deselectionTint = Color("primary_deselection_tint_color")
    }
    
    enum Countdown {
        static let red = Color("countdown_red")
        static let orange = Color("countdown_orange")
        static let green = Color("countdown_green")
        static let gray = Color("countdown_gray")
    }
}
