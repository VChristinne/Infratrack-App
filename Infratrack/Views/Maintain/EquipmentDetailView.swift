//
//  Untitled.swift
//  Infratrack
//
//  Created by Christinne on 10/03/2025.
//

import SwiftUI

struct EquipmentListView: View {
	@Environment(\.presentationMode) var presentationMode

	let type: String
	let equipments: [Equipment]
		
	var body: some View {
		NavigationView {
			List {
				ForEach(equipments) { equipment in
					NavigationLink(destination: EquipmentDetailView(equipment: equipment)) {
						EquipmentRowView(equipment: equipment)
					}
				}
			}
			.navigationTitle(type)
			.navigationBarItems(leading: Button(action: {
				presentationMode.wrappedValue.dismiss()
			}) {
				Label("Voltar", systemImage: "chevron.backward")
					.labelStyle(.automatic)
			})
		}
	}
}

struct EquipmentRowView: View {
	let equipment: Equipment
	
	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(equipment.name)
				.foregroundColor(.primary)
				.font(.headline)
		}
	}
}

struct EquipmentDetailView: View {
	@State private var date = Date()
	@ObservedObject private var calendarManager = CalendarManager.shared

	let equipment: Equipment

	var body: some View {
		VStack {
			Text("""
				**Nome**: \(equipment.name)
				**Número de série**: \(equipment.serial_number)
				**Marca**: \(equipment.brand)
				**Modelo**: \(equipment.model)
				**Tipo**: \(equipment.type)
				"""
			)
			.font(.title3)
			.frame(maxWidth: 600, maxHeight: 200)
			.padding(.trailing, 20)
			
			Text("Agendamento de Manutenção")
				.font(.title)
			
			HStack(spacing: 20) {
				DatePicker("Data", selection: $date, displayedComponents: [.date])
					.datePickerStyle(.graphical)
					.frame(minWidth: 280, maxWidth: 350)
				
				DatePicker("Hora", selection: $date, displayedComponents: [.hourAndMinute])
					.datePickerStyle(.automatic)
					.frame(width: 280)
					.frame(height: 150)
			}
			.frame(maxWidth: 600)
			.padding()
			.background(Color(.secondarySystemFill))
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 1)
			
			Button(action: addEvent) {
				Text("Salvar no Calendário")
					.bold()
					.padding()
					.frame(maxWidth: 200)
					.background(Color.accentColor)
					.foregroundColor(.white)
					.cornerRadius(10)
			}
		}
		.padding()
		.navigationTitle(equipment.name)
	}
	
	func addEvent() {
		let eventTitle = "Manutenção: \(equipment.name)"
		calendarManager.addEvent(title: eventTitle, date: date)
	}
}
