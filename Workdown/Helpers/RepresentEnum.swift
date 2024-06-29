//
//  RepresentEnum.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation

func RepresentPhase(phase: WorkoutPhase?) -> String {
	switch phase {
	case .ExercisePhase(let exercise, let int):
		return "\(exercise.Name) Set \(int)"
	case .RestPhase(let int):
		return "\(int)s Rest"
	case .none:
		return "Done! 🎉"
	}
}
