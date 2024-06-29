//
//  Models.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation

/// Enum used for state modelling
enum WorkoutPhase: Equatable {
	case exercisePhase(Exercise, Int), restPhase(Int)

	static func == (lhs: WorkoutPhase, rhs: WorkoutPhase) -> Bool {
		switch (lhs, rhs) {
		case let (.exercisePhase(lhsExercise, lhsInt), .exercisePhase(rhsExercise, rhsInt)):
			return lhsExercise == rhsExercise && lhsInt == rhsInt
		case let (.restPhase(lhsInt), .restPhase(rhsInt)):
			return lhsInt == rhsInt
		default:
			return false
		}
	}

}

/// Model used for a Workout
struct Workout: Identifiable, Codable {
	var id = UUID()

	var name: String
	var historicalRepetitions: Int
	var _exercises: [Exercise]
	var exercises: [Exercise] {
		get {
			return _exercises
		}
		// These meta-properties for the exercises array automatically get updated when we update the exercise array
		set {
			_exercises = newValue
			var localSetsArray: [WorkoutPhase] = []
			for (itr, exercise) in self.exercises.map({ exercise in (exercise.sets, exercise) }) {
				for inner_i in 1...itr {
					localSetsArray.append(.exercisePhase(exercise, inner_i))
					localSetsArray.append(.restPhase(exercise.rest))
				}
			}
			self.setsArray = localSetsArray
		}
	}
	var totalSetsCount: Int
	var setsArray: [WorkoutPhase]

	init(name: String, historicalRepetitions: Int, exercises: [Exercise]) {
		self.name = name
		self.historicalRepetitions = historicalRepetitions
		self._exercises = exercises
		// commented out in case we need this in the future
		// self.TotalRepsCount = exercises.map({ exercise in exercise.Sets*exercise.Reps }).reduce(0, +)

		var localSetsArray: [WorkoutPhase] = []
		for (itr, exercise) in exercises.map({ exercise in (exercise.sets, exercise) }) {
			for inner_i in 1...itr {
				localSetsArray.append(.exercisePhase(exercise, inner_i))
				localSetsArray.append(.restPhase(exercise.rest))
			}
		}
		self.setsArray = localSetsArray
		totalSetsCount = localSetsArray.count

	}

}

/// Model used for an exercise
struct Exercise: Identifiable, Equatable, Codable {
	var id = UUID()
	var name: String
	var description: String
	var reps: String
	var rest: Int
	var sets: Int
	var exerciseTimer: Int?

	init(name: String, description: String, reps: Int, rest: Int, sets: Int) {
		self.name = name
		self.description = description
		self.reps = String("\(reps) Repetitions")
		self.rest = rest
		self.sets = sets
	}
	
	init(name: String, description: String, reps: String, rest: Int, sets: Int) {
			self.name = name
			self.description = description
			self.reps = reps
			self.rest = rest
			self.sets = sets
	}
	
	init(name: String, description: String, reps: String, rest: Int, sets: Int, exerciseTimer: Int) {
		self.name = name
		self.description = description
		self.reps = reps
		self.rest = rest
		self.sets = sets
		self.exerciseTimer = exerciseTimer
	}
	
	static func == (lhs: Exercise, rhs: Exercise) -> Bool {
		return lhs.id == rhs.id
	}
}

// These extensions are needed for use with `@AppStorage`, but they're currently not in use
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
