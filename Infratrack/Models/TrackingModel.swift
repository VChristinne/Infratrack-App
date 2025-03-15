//
//  TrackingModel.swift
//  Infratrack
//
//  Created by Christinne on 13/03/2025.
//

import Foundation

struct Inspection: Identifiable, Codable {
	var id = UUID()
	var equipment: Equipment
	var employee: Employee
	var type: Metadata.Category = .routine
	var date: Date = Date()
	var notes: String = ""
	var status: Metadata.Status = .pending
	
	init(equipment: Equipment, employee: Employee) {
		self.equipment = equipment
		self.employee = employee
	}
}

struct Metadata {
	enum Category: String, CaseIterable, Codable, Hashable {
		case routine = "Rotina"
		case periodic = "Periódica"
		case eventual = "Eventual"
		case special = "Especial"
		case general = "Geral"
		case security = "Segurança"
		case firefighting = "Sistema de Combate à Incêndio"
	}
	
	enum Status: String, CaseIterable, Codable, Hashable {
		case pending = "Pendente"
		case inProgress = "Em andamento"
		case done = "Concluída"
		case canceled = "Cancelada"
		case denied = "Negada"
	}
}
