//
//  RepresentEnum.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation

func representPhase(phase: WorkoutPhase?) -> String {
	switch phase {
	case .exercisePhase(let exercise, let int):
		return "\(exercise.name) Set \(int)"
	case .restPhase(let int):
		return "\(int)s Rest"
	case .none:
		return "Done! 🎉"
	}
}
