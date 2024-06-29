//
//  WorkoutCycleManager.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI

struct WorkoutManager: View{
	
	@Environment(\.dismiss) var dismiss
	
	var Workout: Workout
	@State var IsRestPeriod = false
	
	@State var WorkoutState: Int
	
	@State var currentPhase: WorkoutPhase?
	@State var nextPhase: WorkoutPhase?
	@State var CurrentSet: Int
	
	@State var SkipToNextScreen = false
	
	@State var WorkoutDone = false
	
	let StartTime: Date


	var body: some View {
		ExerciseView(StartTime: StartTime, SetCount: $CurrentSet, WorkoutState: $WorkoutState, IsRestPeriod: $IsRestPeriod, TotalSetsInWorkout: Workout.TotalSetsCount, SkipToNextScreen: $SkipToNextScreen, currentPhase: $currentPhase, NextPhase: $nextPhase, WorkoutDone: $WorkoutDone)
			.onTapGesture {
				SkipToNextScreen = true
			}
			.onChange(of: SkipToNextScreen) { _, newvalue in
				if newvalue != true { return }
				withAnimation(.linear) {
					SkipToNextScreen = false
					if WorkoutState == Workout.SetsArray.count {
						WorkoutDone = true
						dismiss()
					}
					if WorkoutState == Workout.SetsArray.count + 1 {
						dismiss()
					}
					
					WorkoutState += 1
					currentPhase = Workout.SetsArray[safe: WorkoutState]
				}
			}.onChange(of: WorkoutState) { _, newval in
				withAnimation(.linear) {
					if newval == Workout.SetsArray.count {
						WorkoutDone = true
						//TODO: leave workout
					}
					
					currentPhase = Workout.SetsArray[safe: newval]
					nextPhase = Workout.SetsArray[safe: newval+1]
				}
				
			}
		
	}
	
	
	init(workout: Workout, startTime: Date) {
		self.Workout = workout
		self.StartTime = startTime
		self.currentPhase = Workout.SetsArray[safe: 0]
		self.nextPhase = Workout.SetsArray[safe: 1]
		self.WorkoutState = 0
		self.CurrentSet = 1
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
 

