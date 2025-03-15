import Foundation

/*
 * Generic base class
 * Load and manage resources from a JSON file
 */
class ResourceManager<T: Codable & Identifiable> {
	private(set) var items: [T] = []
	
		// MARK: - INITIALIZER
	private let resourceName: String
	private let fileExtension: String
	private let bundle: Bundle
	
	init(resourceName: String, fileExtension: String = "json", bundle: Bundle = .main) {
		self.resourceName = resourceName
		self.fileExtension = fileExtension
		self.bundle = bundle
		loadFromResources()
	}
	
		// MARK: - LOAD RESOURCES
	private func loadFromResources() {
		guard let path = bundle.path(forResource: resourceName, ofType: fileExtension) else {
			print("Resource file not found: \(resourceName).\(fileExtension)")
			return
		}
		
		let url = URL(fileURLWithPath: path)
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			items = try decoder.decode([T].self, from: data)
		} catch {
			handleError(error, operation: "loading \(resourceName)")
		}
	}
	
		// MARK: - CRUD
	func fetchAll() -> [T] {
		return items
	}
	
	func add(_ item: T) {
		items.append(item)
	}
	
	private func handleError(_ error: Error, operation: String) {
		print("Error \(operation): \(error.localizedDescription)")
	}
}
