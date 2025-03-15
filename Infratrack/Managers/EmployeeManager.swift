import Foundation

class EmployeeManager: ResourceManager<Employee> {
	static let shared = EmployeeManager()
    
		// initializer for singleton
	private init() {
		super.init(resourceName: "employees")
	}
    
	func findByRole(_ role: String) -> [Employee] {
		return fetchAll().filter { $0.role == role }
	}
}
