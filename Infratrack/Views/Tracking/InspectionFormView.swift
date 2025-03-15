//
//  InspectionFormView.swift
//  Infratrack
//
//  Created by Christinne on 13/03/2025.
//

import SwiftUI

struct InspectionFormView: View {
	@Binding var inspection: Inspection
	@Binding var equipments: [Equipment]
	@Binding var employees: [Employee]
	@Binding var types: [Metadata.Category]
	@Binding var status: [Metadata.Status]
	
	@ObservedObject var trackingManager: TrackingManager
	
	var body: some View {
		Form {
			Section(header: Text("Inspeção")) {
				Picker("Nome do Equipamento", selection: $inspection.equipment) {
					ForEach(equipments, id: \.id) { equipment in
						Text(equipment.name).tag(equipment)
					}
				}
				
				Picker("Responsável", selection: $inspection.employee) {
					ForEach(employees, id: \.id) { employee in
						Text(employee.name).tag(employee)
					}
				}
				
				Picker("Tipo de Inspeção", selection: $inspection.type) {
					ForEach(types, id: \.self) { type in
						Text(type.rawValue).tag(type)
					}
				}
				
				Picker("Status", selection: $inspection.status) {
					ForEach(status, id: \.self) { status in
						Text(status.rawValue).tag(status)
					}
				}
				
				DatePicker("Data", selection: $inspection.date, displayedComponents: [.date, .hourAndMinute])
					.datePickerStyle(.compact)
			}
		}
	}
}
