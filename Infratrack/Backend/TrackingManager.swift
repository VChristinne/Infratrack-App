//
//  TrackingManager.swift
//  Infratrack
//
//  Created by Christinne on 13/03/2025.
//

import Foundation

class TrackingManager: ObservableObject {
	static let shared = TrackingManager()
	@Published var inspections: [Inspection] = []
	
	private let fileName = "inspections.json"
	
	init() {
		loadInspections()
	}
	
	func addInspection(_ inspection: Inspection) {
		inspections.append(inspection)
		saveInspections()
	}
	
	private func saveInspections() {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		if let data = try? encoder.encode(inspections) {
			let url = getDocumentsDirectory().appendingPathComponent(fileName)
			try? data.write(to: url)
		}
	}
	
	private func loadInspections() {
		let url = getDocumentsDirectory().appendingPathComponent(fileName)
		if let data = try? Data(contentsOf: url) {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			if let loadedInspections = try? decoder.decode([Inspection].self, from: data) {
				inspections = loadedInspections
			}
		}
	}
	
	private func getDocumentsDirectory() -> URL {
		return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	}
}
