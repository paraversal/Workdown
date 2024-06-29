//
//  WorkoutsList.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI

/// Lists all  `Workout`s passed to the view
struct WorkoutsList: View {
	@Binding var workouts: [Workout]
	var body: some View {
		ZStack {
			Rectangle()
				.ignoresSafeArea()
			NavigationView {
				List($workouts) { $workout in
					NavigationLink(destination: WorkoutDetailView(workout: $workout)) {
						VStack(alignment: .leading) {
							Text(workout.name)
								.font(.headline)
							Text("Total Historical Repetitions: \(workout.historicalRepetitions)")
								.font(.subheadline)
						}
					}
				}
				.navigationTitle("Workouts")
			}
		}
	}
}

#Preview {
	@State var sampleWorkouts = SAMPLEWORKOUT_LIST
	return WorkoutsList(workouts: $sampleWorkouts)
}
