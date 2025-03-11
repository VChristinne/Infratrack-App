//
//  ScheduleModel.swift
//  Infratrack
//
//  Created by Christinne on 11/03/2025.
//

import Foundation

struct Schedule: Identifiable, Codable {
	var id = UUID()
	var equipmentType: String
	var equipmentName: String
	var employeeName: String
	var date: String
}
