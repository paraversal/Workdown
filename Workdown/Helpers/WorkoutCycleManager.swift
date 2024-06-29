//
//  WorkoutCycleManager.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI

struct WorkoutManager: View {
	@Environment(\.dismiss) var dismiss
	var workout: Workout
	@State var isRestPeriod = false
	@State var workoutState: Int
	@State var currentPhase: WorkoutPhase?
	@State var nextPhase: WorkoutPhase?
	@State var currentSet: Int
	@State var skipToNextScreen = false
	@State var workoutDone = false
	let startTime: Date

	var body: some View {
		ExerciseView(startTime: startTime, setCount: $currentSet, workoutState: $workoutState, isRestPeriod: $isRestPeriod, totalSetsInWorkout: workout.totalSetsCount, skipToNextScreen: $skipToNextScreen, currentPhase: $currentPhase, nextPhase: $nextPhase, workoutDone: $workoutDone)
			.onTapGesture {
				skipToNextScreen = true
			}
			.onChange(of: skipToNextScreen) { _, newvalue in
				if newvalue != true { return }
				withAnimation(.linear) {
					skipToNextScreen = false
					if workoutState == workout.setsArray.count {
						workoutDone = true
						dismiss()
					}
					if workoutState == workout.setsArray.count + 1 {
						dismiss()
					}
					workoutState += 1
					currentPhase = workout.setsArray[safe: workoutState]
				}
			}.onChange(of: workoutState) { _, newval in
				withAnimation(.linear) {
					if newval == workout.setsArray.count {
						workoutDone = true
						dismiss()
					}
					currentPhase = workout.setsArray[safe: newval]
					nextPhase = workout.setsArray[safe: newval+1]
				}
			}
	}
	init(workout: Workout, startTime: Date) {
		self.workout = workout
		self.startTime = startTime
		self.currentPhase = workout.setsArray[safe: 0]
		self.nextPhase = workout.setsArray[safe: 1]
		self.workoutState = 0
		self.currentSet = 1
	}
}

#Preview {
 var sampleWorkout = Workout(
	name: "Upper Body Strength",
			 historicalRepetitions: 100,
			 exercises: [
				 Exercise(name: "Bench Press", description: "Press the barbell upwards", reps: "10", rest: 3, sets: 1, exerciseTimer: 30),
				 Exercise(name: "Pull Ups", description: "Pull your body upwards", reps: 8, rest: 3, sets: 1)
			 ]
		 )

	var startTime: Date = {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd hh:mma"
			return dateFormatter.date(from: "2024-06-26 2:40pm") ?? Date()
		}()
	return WorkoutManager(workout: sampleWorkout, startTime: startTime)
}
