//
//  RoundedBarProgressView.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation
import SwiftUI

/// ProgressViewStyle view for the workout completion percentage view in the exercise view
/// Taken from https://codingwithrashid.com/how-to-create-custom-progressview-styles-in-ios-swiftui/
struct RoundedBarProgressView: ProgressViewStyle {
	var completedColor: Color
	var inactiveColor: Color
	func makeBody(configuration: Configuration) -> some View {
		ZStack(alignment: .leading) {
			RoundedRectangle(cornerRadius: 5)
				.fill(inactiveColor)
			RoundedRectangle(cornerRadius: 5)
				.fill(completedColor)
				.frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 200)
		}
		.frame(width: 200, height: 10)
	}
}
