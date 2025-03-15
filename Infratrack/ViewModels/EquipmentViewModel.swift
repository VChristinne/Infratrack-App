import SwiftUI
import Combine

class EquipmentViewModel: ObservableObject {
	@Published var equipments: [Equipment] = []
	private let equipmentManager: EquipmentManager
	
	init(equipmentManager: EquipmentManager = .shared) {
		self.equipmentManager = equipmentManager
		fetchEquipments()
	}
	
	func fetchEquipments() {
		equipments = equipmentManager.fetchAll()
	}
}
