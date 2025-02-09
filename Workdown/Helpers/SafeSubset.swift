//
//  SafeSubset.swift
//  Workdown
//
//  Created by paraversal on 29.06.24.
//

import Foundation

/// Returns the element at the specified index if it is within bounds, otherwise nil.
/// taken from https://stackoverflow.com/a/30593673
extension Collection {
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
