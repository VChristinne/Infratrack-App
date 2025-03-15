import Foundation

class ScheduleManager: PersistentResourceManager<Schedule> {
	static let shared = ScheduleManager()
	
		// initializer for singleton
	private init() {
		super.init(resourceName: "schedules", fileName: "schedules.json")
	}
	
	func removeSchedule(withID id: UUID) {
		if let index = fetchAll().firstIndex(where: { $0.id == id }) {
			var updatedItems = fetchAll()
			updatedItems.remove(at: index)
				// Need to update items array and save
		}
	}
}
