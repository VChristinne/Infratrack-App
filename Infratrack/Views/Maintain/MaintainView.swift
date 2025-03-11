import SwiftUI

struct MaintainView: View {
	@State private var equipments: [Equipment] = []
	@State private var employees: [Employee] = []
	@State private var selectedType: String = ""
	@State private var selectedEquipment: Equipment? = nil
	@State private var selectedEmployee: Employee? = nil
	@State private var date = Date()
	@State private var showForm = false
	
	@ObservedObject private var calendarManager = CalendarManager.shared
	@ObservedObject private var scheduleManager = ScheduleManager.shared
	
	let dataEquipment = EquipmentDataManager.shared
	let dataEmployee = EmployeeDataManager.shared
	
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
				ForEach(scheduleManager.schedules) { schedule in
					VStack(alignment: .leading) {
						Text("**Data**: \(formattedDate(from: schedule.date))")
						Text("**Equipamento**: \(schedule.equipmentName)")
						Text("**Responsável**: \(schedule.employeeName)")
					}
					.swipeActions(edge: .trailing, allowsFullSwipe: false) {
						Button(role: .destructive) {
							if let index = scheduleManager.schedules.firstIndex(where: { $0.id == schedule.id }) {
								scheduleManager.schedules.remove(at: index)
							}
						} label: {
							Label("Delete", systemImage: "trash")
						}
					}
				}
			}
		}
		.sheet(isPresented: $showForm) {
			ScheduleFormView(equipments: $equipments, employees: $employees, selectedType: $selectedType, selectedEquipment: $selectedEquipment, selectedEmployee: $selectedEmployee, date: $date, calendarManager: calendarManager, scheduleManager: scheduleManager)
		}
		.onAppear {
			fetchEquipments()
			fetchEmployees()
		}
		
			// MARK: - CALENDAR ALERTS
		.alert("Erro ao adicionar no calendário", isPresented: $calendarManager.didError) {
			Button("OK", role: .cancel) { }
		} message: {
			Text(calendarManager.errorMessage)
		}
		.alert("Sucesso", isPresented: $calendarManager.eventAddedSuccessfully) {
			Button("OK", role: .cancel) { }
		} message: {
			Text("Evento adicionado ao calendário")
		}
	}
	
		// MARK: - FETCH DATA
	func fetchEquipments() {
		equipments = dataEquipment.fetchEquipments()
	}
	
	func fetchEmployees() {
		employees = dataEmployee.fetchEmployees()
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
	@Binding var equipments: [Equipment]
	@Binding var employees: [Employee]
	@Binding var selectedType: String
	@Binding var selectedEquipment: Equipment?
	@Binding var selectedEmployee: Employee?
	@Binding var date: Date
	
	@ObservedObject var calendarManager: CalendarManager
	@ObservedObject var scheduleManager: ScheduleManager
	
	var body: some View {
		Form {
			Section(header: Text("Equipamento")) {
				Picker("Tipo", selection: $selectedType) {
					ForEach(Array(Set(equipments.map { $0.type })).sorted(), id: \.self) { type in
						Text(type).tag(type)
					}
				}
				
				Picker("Nome", selection: $selectedEquipment) {
					ForEach(equipments.filter { $0.type == selectedType }, id: \.id) { equipment in
						Text(equipment.name).tag(equipment as Equipment?)
					}
				}
				
				Picker("Responsável", selection: $selectedEmployee) {
					ForEach(employees, id: \.id) { employee in
						Text(employee.name).tag(employee as Employee?)
					}
				}
			}
			
			Section(header: Text("Agendamento")) {
				DatePicker("Data/Hora", selection: $date, displayedComponents: [.date, .hourAndMinute])
					.datePickerStyle(.compact)
				
				Button(action: {
					let newSchedule = Schedule(
						equipmentType: selectedEquipment?.type ?? "",
						equipmentName: selectedEquipment?.name ?? "",
						employeeName: selectedEmployee?.name ?? "",
						date: date.iso8601String
					)
					scheduleManager.addSchedule(newSchedule)
					calendarManager.addEvent(title: "Manutenção: \(selectedEquipment?.name ?? "")", date: date)
				}) {
					Text("Salvar no calendário")
				}
			}
		}
	}
}

extension Date {
	var iso8601String: String {
		return ISO8601DateFormatter().string(from: self)
	}
}
