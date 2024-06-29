//
//  ExerciseView.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import SwiftUI
import Foundation

struct ExerciseView: View {
	
	@Environment(\.dismiss) var dismiss
	
	var StartTime: Date
	@State var Timer: String = "00:00"
	@Binding var SetCount: Int
	@Binding var WorkoutState: Int
	@Binding var IsRestPeriod: Bool
	var TotalSetsInWorkout: Int
	@Binding var SkipToNextScreen: Bool
	
	@Binding var currentPhase: WorkoutPhase?
	@Binding var NextPhase: WorkoutPhase?
	
	@Binding var WorkoutDone: Bool
	
	var body: some View {
		
		let timer = Foundation.Timer.publish(every: 1, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
		// MARK: - Progress Box
		ZStack {
			VStack {
				HStack {
					Button(action: {dismiss()}, label: {
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
							Text(Timer)
								.font(.title)
								.padding(.bottom)
								.bold()
								.scaleEffect(1.5)
								.onReceive(timer) { currentTime in
									if !WorkoutDone {
										Timer = timeElapsedBetween(StartTime, currentTime)
									}
								}
							ProgressView(value: Double(WorkoutState), total: Double(TotalSetsInWorkout))
								.progressViewStyle(RoundedBarProgressView(completedColor: .green.opacity(0.7), inactiveColor: .gray.opacity(0.5)))
							
						}
					}
					.frame(width: 300, height: 150)
					.padding(.top, 20)
					.shadow(color: .gray.opacity(0.4), radius: 20)
				
				
				Spacer()
				
				if WorkoutDone {
					Text("Workout Done!").font(.title).bold()
				}
				
				// MARK: - Middle Box
				switch currentPhase {
					case .ExercisePhase(let exercise, _):
						ExerciseTextView(Exercise: exercise, WorkoutState: $WorkoutState).transition(.slide)
						.shadow(color: .gray.opacity(0.4), radius: 20)
					case .RestPhase(let int):
						RestView(restTime: int, NextPhase: NextPhase, WorkoutState: $WorkoutState, IsRestPeriod: $IsRestPeriod).transition(.slide)
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
								Text("Set \(SetCount)")
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
									
									Text(RepresentPhase(phase: NextPhase))
										.font(.callout)
								}
								Spacer()
								
							}
						}
						
					}.padding(.bottom, 30)
					.onChange(of: currentPhase) { _, newValue in
						switch newValue {
						case .ExercisePhase(_, let int):
							SetCount = int
						case .RestPhase(_):
							IsRestPeriod = true
						case .none:
							()
						}
					}.offset(y: WorkoutDone ? 200 : 0)
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
	
	var Exercise: Exercise
	@State var exerciseTimer: Int?
	@Binding var WorkoutState: Int
	
	init(Exercise: Exercise, WorkoutState: Binding<Int>){
		if let tm = Exercise.ExerciseTimer {
			exerciseTimer = tm
		}
		self.Exercise = Exercise
		self._WorkoutState = WorkoutState
	}
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
				.foregroundStyle(.cyan.opacity(0.2))
				.padding(.all, 50)
			VStack {
				Text(Exercise.Name)
					.font(.largeTitle)
					.multilineTextAlignment(.center)
					.bold()
					.padding()
					.frame(width: 250)
					.scaledToFill()
					.minimumScaleFactor(0.5)
					.lineLimit(1)
				
				Text("\(Exercise.Reps)")
					.font(.callout)
					.bold()
					.padding()
				
				Text(Exercise.Description)
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
								WorkoutState += 1
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
	var NextPhase: WorkoutPhase?
	@Binding var WorkoutState: Int
	@Binding var IsRestPeriod: Bool
	
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
						WorkoutState += 1
						IsRestPeriod = false
					}
					.onReceive(timer, perform: { _ in
						if IsRestPeriod {
							if restTime <= 0 {
								withAnimation() {
									IsRestPeriod = false
									WorkoutState += 1
								}
								
								
							}
							self.restTime = max(self.restTime - 1, 0)
						}
						
					})
			}
		}
	}
}
