//
//  WorkdownApp.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI

@main
struct WorkdownApp: App {
	@State var workouts: [Workout] = MYWORKOUTS
	var body: some Scene {
		WindowGroup {
			WorkoutsList(workouts: $workouts)
				.preferredColorScheme(.dark)
		}
	}
}
