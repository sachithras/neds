//
//  AppFonts.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation
import SwiftUI

enum AppFont {
    static var listingTitlePrimary: Font {
        Font.custom("AvenirNext-Regular", size: 16)
    }

    static var listingSubTitlePrimary: Font {
        Font.custom("AvenirNext-Regular", size: 14)
    }
    
    static var countdownPrimary: Font {
        Font.custom("AvenirNext-Bold", size: 12)
    }
    
    static var spinnerPrimary: Font {
        Font.custom("AvenirNext-Regular", size: 12)
    }
    
    static var errorTitlePrimary: Font {
        Font.custom("AvenirNext-Regular", size: 16)
    }
}
