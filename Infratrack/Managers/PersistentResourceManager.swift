import Foundation

/*
 * Generic class
 * Manages resources of a given type for persistence
 */
class PersistentResourceManager<T: Codable & Identifiable>: ResourceManager<T> {
	private let fileName: String
	private let fileManager: FileManager
	
	init(resourceName: String, fileName: String, fileManager: FileManager = .default) {
		self.fileName = fileName
		self.fileManager = fileManager
		super.init(resourceName: resourceName)
	}
	
		// save items to documents directory
	func saveItems() {
		do {
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			
			let data = try encoder.encode(fetchAll())
			let url = getDocumentsDirectory().appendingPathComponent(fileName)
			try data.write(to: url)
		} catch {
			handleError(error, operation: "saving items")
		}
	}
	
		// save after adding
	override func add(_ item: T) {
		super.add(item)
		saveItems()
	}
	
	private func getDocumentsDirectory() -> URL {
		return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
	}
	
	private func handleError(_ error: Error, operation: String) {
		print("Error \(operation): \(error.localizedDescription)")
	}
}
