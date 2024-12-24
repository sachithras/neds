//
//  NedsErrorView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import SwiftUI

struct NedsErrorView: View {
    
    var errorMessage: String
    
    let onRetry: () -> Void
    
    var body: some View {
        Spacer()
        Text(errorMessage).padding()
        Button(action: {
            onRetry()
        }) {
            Text("Retry now")
                .padding()
                .cornerRadius(10)
        }
        .background(Color(AppColors.Button.primaryBackgroundColor))
        .foregroundStyle(Color(AppColors.Button.primaryForegroundColor))
        Spacer()
    }
}

#Preview {
    NedsErrorView(errorMessage: "API error, Please try again.",
                  onRetry: {
        print("retry tapped")
    })
}
