//
//  DateCalculator.swift
//  Workdown
//
//  Created by paraversal on 26.06.24.
//

import Foundation

func timeElapsedBetween(_ startDate: Date, _ nowDate: Date) -> String {
    let elapsedTimeInterval = nowDate.timeIntervalSince(startDate)
    let hours = Int(elapsedTimeInterval) / 3600
    let minutes = (Int(elapsedTimeInterval) % 3600) / 60
    let seconds = Int(elapsedTimeInterval) % 60
	if hours < 1 {
		return String(format: "%02d:%02d", minutes, seconds)
	} else {
		return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
	}
   }
