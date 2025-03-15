import Foundation

class EquipmentManager: ResourceManager<Equipment> {
	static let shared = EquipmentManager()
	
		// initializer for singleton
	private init() {
		super.init(resourceName: "equipments")
	}
	
	func findByType(_ type: String) -> [Equipment] {
		return fetchAll().filter { $0.type == type }
	}
	
	func addEquipment(name: String, serial_number: String, brand: String, model: String, type: String, doc: String) {
		let newEquipment = Equipment(id: UUID(), name: name, serial_number: serial_number, brand: brand, model: model, type: type, doc: doc)
		add(newEquipment)
	}
}
