//
//  ExerciseView.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI
import Foundation

/// Shows information about the current `WorkoutPhase` as well as the upcoming `ExercisePhase`
struct ExerciseView: View {
	@Environment(\.dismiss) var dismiss
	var startTime: Date
	@State var timer: String = "00:00"
	@Binding var setCount: Int
	@Binding var workoutState: Int
	@Binding var isRestPeriod: Bool
	var totalSetsInWorkout: Int
	@Binding var skipToNextScreen: Bool
	@Binding var currentPhase: WorkoutPhase?
	@Binding var nextPhase: WorkoutPhase?
	@Binding var workoutDone: Bool
	var body: some View {
		let timerPublisher = Foundation.Timer.publish(every: 1, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
		// MARK: - Progress Box
		ZStack {
			VStack {
				HStack {
					Button(action: {
						dismiss()
					}, label: {
						ZStack {
							RoundedRectangle(cornerRadius: 10.0)
								.frame(width: 60, height: 30)
								.foregroundColor(.gray.opacity(0.1))
							Image(systemName: "arrowshape.backward.fill")
								.font(.headline)
								.foregroundColor(.black.opacity(0.5))
						}.padding(.horizontal)
						 .shadow(radius: 5)
					})

					Spacer()
				}
				RoundedRectangle(cornerRadius: 25.0)
					.foregroundStyle(.blue.opacity(0.15))
					.overlay {
						VStack {
							Text(timer)
								.font(.title)
								.padding(.bottom)
								.bold()
								.scaleEffect(1.5)
								.onReceive(timerPublisher) { currentTime in
									if !workoutDone {
										withAnimation(.snappy) {
											timer = timeElapsedBetween(startTime, currentTime)
										}
									}
								}
							ProgressView(value: Double(workoutState), total: Double(totalSetsInWorkout))
								.progressViewStyle(RoundedBarProgressView(completedColor: .green.opacity(0.7), inactiveColor: .gray.opacity(0.5)))

						}
					}
					.frame(width: 300, height: 150)
					.padding(.top, 20)
					.shadow(color: .gray.opacity(0.4), radius: 20)

				Spacer()

				if workoutDone {
					Text("Workout Done!").font(.title).bold()
				}

				// MARK: - Middle Box
				switch currentPhase {
				case .exercisePhase(let exercise, _):
					ExerciseTextView(exercise: exercise, workoutState: $workoutState).transition(.slide)
					.shadow(color: .gray.opacity(0.4), radius: 20)
				case .restPhase(let int):
					RestView(restTime: int, nextPhase: nextPhase, workoutState: $workoutState, isRestPeriod: $isRestPeriod).transition(.slide)
					.shadow(color: .gray.opacity(0.4), radius: 20)
				case .none:
					EmptyView()
				}
				Spacer()
				// MARK: - Bottom box
				RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
					.foregroundStyle(.green.opacity(0.10))
					.frame(width: 350, height: 100).overlay {
						VStack {
							HStack {
								Spacer()
								Text("Set \(setCount)")
									.font(.title3)
									.bold()
								Spacer()
								Rectangle()
									.frame(width: 1, height: 60)
								Spacer()

								// NEXT UP
								VStack {
									Text("Next up:")
										.font(.body).bold()
										.padding(.bottom, 2)

									Text(representPhase(phase: nextPhase))
										.font(.callout)
								}
								Spacer()

							}
						}

					}.padding(.bottom, 30)
					.onChange(of: currentPhase) { _, newValue in
						switch newValue {
						case .exercisePhase(_, let int):
							setCount = int
						case .restPhase:
							isRestPeriod = true
						case .none:
							()
						}
					}.offset(y: workoutDone ? 200 : 0)
					.transition(.push(from: .bottom))
					.shadow(color: .gray.opacity(0.7), radius: 20)
			}
			.foregroundStyle(Color.primary)
			.backgroundStyle(Color.secondary)
		}
	}
}

// MARK: - Middle Box Exercise Phase View
struct ExerciseTextView: View {

	var exercise: Exercise
	@State var exerciseTimer: Int?
	@Binding var workoutState: Int

	init(exercise: Exercise, workoutState: Binding<Int>) {
		if let tm = exercise.exerciseTimer {
			exerciseTimer = tm
		}
		self.exercise = exercise
		self._workoutState = workoutState
	}

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
				.foregroundStyle(.cyan.opacity(0.2))
				.padding(.all, 50)
			VStack {
				Text(exercise.name)
					.font(.largeTitle)
					.multilineTextAlignment(.center)
					.bold()
					.padding()
					.frame(width: 250)
					.scaledToFill()
					.minimumScaleFactor(0.5)
					.lineLimit(1)
				Text("\(exercise.reps)")
					.font(.callout)
					.bold()
					.padding()
				Text(exercise.description)
					.multilineTextAlignment(.center)
					.font(.body)
					.padding()
					.frame(width: 300)
					.scaledToFill()
					.minimumScaleFactor(0.5)
				if exerciseTimer != nil {
					let timer = Foundation.Timer.publish(every: 1, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
					Text("\(exerciseTimer ?? 0)s")
						.font(.title)
						.bold()
						.padding()
						.onReceive(timer, perform: { _ in
							if exerciseTimer ?? 0 <= 0 {
								workoutState += 1
							} else if exerciseTimer! > 0 {
								exerciseTimer! -= 1
							}
						})
				}
			}
		}
	}
}

// MARK: - Middle Box Rest Phase View
struct RestView: View {
	@State var restTime: Int
	var nextPhase: WorkoutPhase?
	@Binding var workoutState: Int
	@Binding var isRestPeriod: Bool

	let timer = Foundation.Timer.publish(every: 1, on: .main, in: .common).autoconnect().eraseToAnyPublisher()

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 25.0)
				.foregroundStyle(.green.opacity(0.7))
				.frame(width: 250, height: 250)
			VStack {
				Text("Rest")
					.font(.largeTitle)
					.opacity(0.7)
					.multilineTextAlignment(.center)
					.bold()
					.padding(.bottom, 20)
				Text("\(restTime)s")
					.font(.largeTitle)
					.opacity(0.9)
					.scaleEffect(2)
					.multilineTextAlignment(.center)
					.bold()
					.padding(.bottom, 30)
					.onTapGesture {
						withAnimation(.snappy) {
							workoutState += 1
							isRestPeriod = false
						}
					}
					.onReceive(timer, perform: { _ in
						withAnimation(.snappy) {
							if isRestPeriod {
								if restTime <= 0 {
									isRestPeriod = false
									workoutState += 1
									
								}
								self.restTime = max(self.restTime - 1, 0)
							}
						}
					})
			}
		}
	}
}
