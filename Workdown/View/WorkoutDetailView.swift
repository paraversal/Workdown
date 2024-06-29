//
//  WorkoutDetailView.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI

struct WorkoutDetailView: View {
	
	@Binding var workout: Workout
	@State private var editMode = EditMode.inactive
	
	@State var WorkoutPresent = false
	
	var body: some View {

		VStack {
			List{
				ForEach($workout.Exercises, editActions: .delete) { $exercise in
					ExercisePreview(exercise: $exercise)
				}
					
			}
			 .navigationBarItems(
					trailing:
						HStack {
							EditButton()
							addButton
					})
		}
		HStack {
			RoundedRectangle(cornerRadius: 10)
				.frame(width: 70, height: 50)
				.foregroundStyle(.orange.opacity(0.50))
				.overlay {
					Text("\(workout.HistoricalRepetitions)x")
						.font(.title2)
						.foregroundStyle(.white.opacity(0.9))
						.scaledToFill()
						.minimumScaleFactor(0.1)
				}
			
			Button {
				WorkoutPresent.toggle()
			} label: {
				RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
					.frame(width: 250, height: 70)
					.padding()
					.foregroundStyle(.indigo.opacity(0.70))
					.overlay {
						Text("Start Workout")
							.font(.title3.bold())
							.foregroundStyle(.white.opacity(0.9))
					}
			}.fullScreenCover(isPresented: $WorkoutPresent, onDismiss: {
				workout.HistoricalRepetitions += 1
			}, content: {
				WorkoutManager(workout: workout, startTime: Date())
			})
		}
		
	}
	
	private var addButton: some View {
		   switch editMode {
		   case .inactive:
			   return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
		   default:
			   return AnyView(EmptyView())
		   }
	   }
	
	func onAdd() {
			// To be implemented in the next section
		}
	
}

struct ExercisePreview: View {
	
	@Binding var exercise: Exercise
	
	var body: some View {
		VStack(alignment: .leading, content: {
			Text(exercise.Name)
				.font(.title)
				.bold()
			Text("\(exercise.Reps), \(exercise.Sets) Sets")
				.font(.callout)
				.bold()
			Text(exercise.Description)
				.font(.callout)
			Text("Rest Period: \(exercise.Rest)s")
				.font(.footnote)
			
				
			
		})
		.frame(alignment: .leading)
		.padding()
	
	}
	
	// TODO: add one to historicalRepetitions
	
}

#Preview {
	
	@State var workoutlist = SAMPLEWORKOUT_LIST
	@State var workout = SAMPLEWORKOUT
	
	return WorkoutDetailView(workout: $workout)
}
