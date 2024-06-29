//
//  WorkoutsList.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI

struct WorkoutsList: View {
	
	@Binding var workouts: [Workout]
	
	var body: some View {
		ZStack {
			Rectangle()
				.frame(width: .infinity, height: .infinity)
				.ignoresSafeArea()
			NavigationView {
				List($workouts) { $workout in
					NavigationLink(destination: WorkoutDetailView(workout: $workout)) {
						VStack(alignment: .leading) {
							Text(workout.Name)
								.font(.headline)
							Text("Total Historical Repetitions: \(workout.HistoricalRepetitions)")
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

