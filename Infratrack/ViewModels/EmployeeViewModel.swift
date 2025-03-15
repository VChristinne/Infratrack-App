import SwiftUI
import Combine

class EmployeeViewModel: ObservableObject {
	@Published var employees: [Employee] = []
	private let employeeManager: EmployeeManager
	
	init(employeeManager: EmployeeManager = .shared) {
		self.employeeManager = employeeManager
		fetchEmployees()
	}
	
	func fetchEmployees() {
		employees = employeeManager.fetchAll()
	}
}
