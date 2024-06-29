//
//  Models.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation

enum WorkoutPhase: Equatable {
	case ExercisePhase(Exercise, Int), RestPhase(Int)
	
	static func == (lhs: WorkoutPhase, rhs: WorkoutPhase) -> Bool {
		switch (lhs, rhs) {
		case let (.ExercisePhase(lhsExercise, lhsInt), .ExercisePhase(rhsExercise, rhsInt)):
			return lhsExercise == rhsExercise && lhsInt == rhsInt
		case let (.RestPhase(lhsInt), .RestPhase(rhsInt)):
			return lhsInt == rhsInt
		default:
			return false
		}
	}
	
}

struct Workout: Identifiable, Codable {
	var id = UUID()
	
	var Name: String
	var HistoricalRepetitions: Int
	var _exercises: [Exercise]
	var Exercises: [Exercise] {
		get {
			return _exercises
		}
		// These meta-properties for the exercises array automatically get updated when we update the exercise array
		// This doesn't allow for super flexible exercise layouts, but that's fine for now
		set {
			_exercises = newValue
			
			
			var LocalSetsArray: [WorkoutPhase] = []
			for (i, exercise) in self.Exercises.map({ exercise in (exercise.Sets, exercise) }) {
				for inner_i in 1...i {
					LocalSetsArray.append(.ExercisePhase(exercise, inner_i))
					LocalSetsArray.append(.RestPhase(exercise.Rest))
				}
			}
			SetsArray = LocalSetsArray
			
			
		}
	}
	
	var TotalSetsCount: Int
	var SetsArray: [WorkoutPhase]
	
	init(name: String, historicalRepetitions: Int, exercises: [Exercise]) {
		self.Name = name
		self.HistoricalRepetitions = historicalRepetitions
		self._exercises = exercises
		// commented out in case we need this in the future
		// self.TotalRepsCount = exercises.map({ exercise in exercise.Sets*exercise.Reps }).reduce(0, +)
					
		var LocalSetsArray: [WorkoutPhase] = []
		for (i, exercise) in exercises.map({ exercise in (exercise.Sets, exercise) }) {
			for inner_i in 1...i {
				LocalSetsArray.append(.ExercisePhase(exercise, inner_i))
				LocalSetsArray.append(.RestPhase(exercise.Rest))
			}
		}
		self.SetsArray = LocalSetsArray
		TotalSetsCount = LocalSetsArray.count

	}
	
}

struct Exercise: Identifiable, Equatable, Codable {
	var id = UUID()
	
	var Name: String
	var Description: String
	var Reps: String
	var Rest: Int
	var Sets: Int
	
	var ExerciseTimer: Int? = nil
	
	init(name: String, description: String, reps: Int, rest: Int, sets: Int) {
		self.Name = name
		self.Description = description
		self.Reps = String("\(reps) Repetitions")
		self.Rest = rest
		self.Sets = sets
	}
	
	init(name: String, description: String, reps: String, rest: Int, sets: Int) {
			self.Name = name
			self.Description = description
			self.Reps = reps
			self.Rest = rest
			self.Sets = sets
		}
	
	init(name: String, description: String, reps: String, rest: Int, sets: Int, exerciseTimer: Int) {
		self.Name = name
		self.Description = description
		self.Reps = reps
		self.Rest = rest
		self.Sets = sets
		self.ExerciseTimer = exerciseTimer
	}
	
	static func == (lhs: Exercise, rhs: Exercise) -> Bool {
		
		return lhs.id == rhs.id
		
	}
}

extension Workout: RawRepresentable {
	public init?(rawValue: String) {
			guard let data = rawValue.data(using: .utf8),
				let result = try? JSONDecoder().decode(Workout.self, from: data)
			else {
				return nil
			}
			self = result
		}

		public var rawValue: String {
			guard let data = try? JSONEncoder().encode(self),
				let result = String(data: data, encoding: .utf8)
			else {
				return "[]"
			}
			return result
		}
}


extension [Workout]: RawRepresentable {
	public init?(rawValue: String) {
			guard let data = rawValue.data(using: .utf8),
				let result = try? JSONDecoder().decode(Workout.self, from: data)
			else {
				return nil
			}
			self = [result]
		}

		public var rawValue: String {
			guard let data = try? JSONEncoder().encode(self),
				let result = String(data: data, encoding: .utf8)
			else {
				return "[]"
			}
			return result
		}
}
