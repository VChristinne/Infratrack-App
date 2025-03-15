import SwiftUI

struct MaintainView: View {
	@StateObject private var viewModel = MaintainViewModel()
	@State private var showForm = false
	
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					showForm.toggle()
				}) {
					Label("Manutenção", systemImage: "plus")
				}
				.labelStyle(.iconOnly)
				.buttonStyle(.borderless)
				
				Spacer()
			}
			.padding(.horizontal)
			
				// MARK: - SCHEDULE LIST
			List {
				ForEach(viewModel.schedules) { schedule in
					VStack(alignment: .leading) {
						Text("**Data**: \(viewModel.formattedDate(from: schedule.date))")
						Text("**Equipamento**: \(schedule.equipmentName)")
						Text("**Responsável**: \(schedule.employeeName)")
					}
					.swipeActions(edge: .trailing, allowsFullSwipe: false) {
						Button(role: .destructive) {
							if let index = viewModel.schedules.firstIndex(where: { $0.id == schedule.id }) {
									// deleteSchedule()
							}
						} label: {
							Label("Delete", systemImage: "trash")
						}
					}
				}
			}
		}
		.sheet(isPresented: $showForm) {
			ScheduleFormView(viewModel: viewModel)
		}
		
			// MARK: - CALENDAR ALERTS
		.alert("Erro ao adicionar no calendário", isPresented: Binding<Bool>(
			get: { CalendarManager.shared.didError },
			set: { _ in }
		)) {
			Button("OK", role: .cancel) { }
		} message: {
			Text(CalendarManager.shared.errorMessage)
		}
		.alert("Sucesso", isPresented: Binding<Bool>(
			get: { CalendarManager.shared.eventAddedSuccessfully },
			set: { _ in }
		)) {
			Button("OK", role: .cancel) { }
		} message: {
			Text("Evento adicionado ao calendário")
		}
	}
	
		// MARK: - DATE FORMATTING
	func formattedDate(from isoString: String) -> String {
		let isoFormatter = ISO8601DateFormatter()
		if let date = isoFormatter.date(from: isoString) {
			let formatter = DateFormatter()
			formatter.dateStyle = .long
			formatter.timeStyle = .short
			return formatter.string(from: date)
		}
		return isoString
	}
}

	// MARK: - ScheduleFormView
struct ScheduleFormView: View {
	@Environment(\.dismiss) var dismiss
	@ObservedObject var viewModel: MaintainViewModel
	
	var body: some View {
		Form {
			Section(header: Text("Equipamento")) {
				Picker("Tipo", selection: $viewModel.selectedType) {
					ForEach(Array(Set(viewModel.equipments.map { $0.type })).sorted(), id: \.self) { type in
						Text(type).tag(type)
					}
				}
				
				Picker("Nome", selection: $viewModel.selectedEquipment) {
					ForEach(viewModel.equipments.filter { $0.type == viewModel.selectedType }, id: \.id) { equipment in
						Text(equipment.name).tag(equipment as Equipment?)
					}
				}
				
				Picker("Responsável", selection: $viewModel.selectedEmployee) {
					ForEach(viewModel.employees, id: \.id) { employee in
						Text(employee.name).tag(employee as Employee?)
					}
				}
			}
			
			Section(header: Text("Agendamento")) {
				DatePicker("Data/Hora", selection: $viewModel.date, displayedComponents: [.date, .hourAndMinute])
					.datePickerStyle(.compact)
				
				Button(action: {
					viewModel.addSchedule()
					dismiss()
				}) {
					Text("Salvar no calendário")
				}
				.disabled(viewModel.selectedEquipment == nil || viewModel.selectedEmployee == nil)
			}
		}
	}
}
