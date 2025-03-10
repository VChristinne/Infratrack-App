import Foundation

class EquipmentDataManager {
	static let shared = EquipmentDataManager()
	private var equipments: [Equipment] = []
	
	private init() {
		loadEquipmentsFromResources()
	}
	
	func loadEquipmentsFromResources() {
		guard let path = Bundle.main.path(forResource: "equipments", ofType: "json") else {
			print("JSON file not found in Bundle (Resources)")
			return
		}
		
		let url = URL(fileURLWithPath: path)
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			let equipments = try decoder.decode([Equipment].self, from: data)
			self.equipments = equipments
		} catch {
			print("Error loading equipments: \(error)")
		}
	}
	
	func fetchEquipments() -> [Equipment] {
		return equipments
	}
	
	func addEquipment(_ equipment: Equipment) {
		equipments.append(equipment)
	}
}
