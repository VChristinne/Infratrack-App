import Foundation

class ScheduleManager: ObservableObject {
	static let shared = ScheduleManager()
	@Published var schedules: [Schedule] = []
	
	private let fileName = "schedules.json"
	
	init() {
		loadSchedules()
	}
	
	func addSchedule(_ schedule: Schedule) {
		schedules.append(schedule)
		saveSchedules()
	}
	
	private func saveSchedules() {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		if let data = try? encoder.encode(schedules) {
			let url = getDocumentsDirectory().appendingPathComponent(fileName)
			try? data.write(to: url)
		}
	}
	
	private func loadSchedules() {
		let url = getDocumentsDirectory().appendingPathComponent(fileName)
		if let data = try? Data(contentsOf: url) {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			if let loadedSchedules = try? decoder.decode([Schedule].self, from: data) {
				schedules = loadedSchedules
			}
		}
	}
	
	private func getDocumentsDirectory() -> URL {
		return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	}
}
