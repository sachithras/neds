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
        Text(errorMessage)
        Button(action: {
            onRetry()
        }) {
            Text("Retry now")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
    NedsErrorView(errorMessage: "API error, Please try again.",
                  onRetry: {
        print("retry tapped")
    })
}
