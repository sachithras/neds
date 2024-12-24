//
//  NedsSpinnerView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import SwiftUI

struct NedsSpinnerView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .padding()
            Text("Loading...")
                .font(AppFont.spinnerPrimary)
                .foregroundColor(Color(AppColors.Text.primaryTextColor))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    NedsSpinnerView()
}
