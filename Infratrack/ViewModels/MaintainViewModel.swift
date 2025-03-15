import SwiftUI
import Combine

class MaintainViewModel: ObservableObject {
		// MARK: - PROPERTIES
	@Published var equipments: [Equipment] = []
	@Published var employees: [Employee] = []
	@Published var schedules: [Schedule] = []
	@Published var selectedType: String = ""
	@Published var selectedEquipment: Equipment?
	@Published var selectedEmployee: Employee?
	@Published var date = Date()
	
		// MARK: - MANAGERS
	private let equipmentManager: EquipmentManager
	private let employeeManager: EmployeeManager
	private let scheduleManager: ScheduleManager
	private let calendarManager: CalendarManager
	
		// managing subscriptions
	private var cancellables = Set<AnyCancellable>()
	
		// MARK: - INITIALIZER
	init(
		equipmentManager: EquipmentManager = .shared,
		employeeManager: EmployeeManager = .shared,
		scheduleManager: ScheduleManager = .shared,
		calendarManager: CalendarManager = .shared
	) {
		self.equipmentManager = equipmentManager
		self.employeeManager = employeeManager
		self.scheduleManager = scheduleManager
		self.calendarManager = calendarManager
		
		setupBindings()
		
		fetchEquipments()
		fetchEmployees()
		fetchSchedules()
	}
	
	private func setupBindings() {
			// Set up Publishers here
	}
	
		// MARK: - DATA FETCHING
	func fetchEquipments() {
		equipments = equipmentManager.fetchAll()
	}
	
	func fetchEmployees() {
		employees = employeeManager.fetchAll()
	}
	
	func fetchSchedules() {
		schedules = scheduleManager.fetchAll()
	}
	
		// MARK: - BUSSINESS LOGIC
	func addSchedule() {
		guard let equipment = selectedEquipment, let employee = selectedEmployee else {
			return
		}
		
		let newSchedule = Schedule(
			equipmentType: equipment.type,
			equipmentName: equipment.name,
			employeeName: employee.name,
			date: date.iso8601String
		)
		
		scheduleManager.add(newSchedule)
		calendarManager.addEvent(title: "Manutenção: \(equipment.name)", date: date)
	}
	
	func deleteSchedule(at indexSet: IndexSet) {
		 // Delete Schedule from ScheduleManager
	}
	
		// MARK: - DATA HELPER
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

extension Date {
	var iso8601String: String {
		return ISO8601DateFormatter().string(from: self)
	}
}
