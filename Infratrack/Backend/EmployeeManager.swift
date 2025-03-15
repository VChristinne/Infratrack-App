import Foundation

class EmployeeManager {
    static let shared = EmployeeManager()
    private var employees: [Employee] = []
    
    private init() {
        loadEmployeesFromResources()
    }
    
    func loadEmployeesFromResources() {
        guard let path = Bundle.main.path(forResource: "employees", ofType: "json") else {
            print("JSON file not found in Bundle (Resources)")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let employees = try decoder.decode([Employee].self, from: data)
            self.employees = employees
        } catch {
            print("Error loading employees: \(error)")
        }
    }
    
    func fetchEmployees() -> [Employee] {
        return employees
    }
    
    func addEmployee(_ employee: Employee) {
        employees.append(employee)
    }
}
