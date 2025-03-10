import SwiftUI

struct MaintainView: View {
	@State private var equipments: [Equipment] = []
	@State private var selectedType: String? = "Modelo A"
	@State private var isAddEquipment = false
	@State private var showEquipmentList = false
	
	@ObservedObject private var calendarManager = CalendarManager.shared
	
	let data = EquipmentDataManager.shared
	
	var body: some View {
		GeometryReader { geometry in
			let gridItems = [GridItem(.adaptive(minimum: 100), spacing: 12)]
			
			ScrollView {
				LazyVGrid(columns: gridItems) {
					ForEach(groupedEquipments.keys.sorted(), id: \.self) { type in
						Button(action: {
							selectedType = type
							showEquipmentList = true
							debugPrint("Button pressed, selected type: \(selectedType ?? "None")")
						}) {
							EquipmentCardView(type: type)
						}
					}
				}
				.padding()
			}
			
			.sheet(isPresented: $isAddEquipment) {
				AddEquipmentView()
			}
			
			.alert("Erro ao adicionar no calendário",
				   isPresented: $calendarManager.didError) {
				Button("OK", role: .cancel) { }
			} message: {
				Text(calendarManager.errorMessage)
			}
			
			.alert("Sucesso",
				   isPresented: $calendarManager.eventAddedSuccessfully) {
				Button("OK", role: .cancel) { }
			} message: {
				Text("Evento adicionado ao calendário")
			}
			
		}
		.onAppear {
			fetchEquipments()
		}
		
		.fullScreenCover(isPresented: $showEquipmentList) {
			if let selectedType = selectedType {
				let equipmentsForType = groupedEquipments[selectedType] ?? []
				EquipmentListView(type: selectedType, equipments: equipmentsForType)
					.onAppear {
						debugPrint("Selected type: \(selectedType), Equipments: \(equipmentsForType)")
					}
			}
		}
	}
	
	var groupedEquipments: [String: [Equipment]] {
		let grouped = Dictionary(grouping: equipments, by: { $0.type })
		return grouped
	}
	
	func fetchEquipments() {
			//equipments = data.fetchEquipments()
		equipments = [
			Equipment(id: UUID(), name: "Equipamento 1", serial_number: "Tipo A", brand: "123456", model: "Marca A", type: "Modelo A", doc: "Documentação A"),
			Equipment(id: UUID(), name: "Equipamento 2", serial_number: "Tipo A", brand: "123456", model: "Marca A", type: "Modelo A", doc: "Documentação B"),
			Equipment(id: UUID(), name: "Equipamento 3", serial_number: "Tipo B", brand: "123456", model: "Marca B", type: "Modelo B", doc: "Documentação C"),
			Equipment(id: UUID(), name: "Equipamento 4", serial_number: "Tipo B", brand: "123456", model: "Marca B", type: "Modelo B", doc: "Documentação D"),
			Equipment(id: UUID(), name: "Equipamento 5", serial_number: "Tipo C", brand: "123456", model: "Marca C", type: "Modelo C", doc: "Documentação E"),
			Equipment(id: UUID(), name: "Equipamento 6", serial_number: "Tipo C", brand: "123456", model: "Marca E", type: "Modelo C", doc: "Documentação F"),
			Equipment(id: UUID(), name: "Equipamento 7", serial_number: "Tipo D", brand: "123456", model: "Marca D", type: "Modelo D", doc: "Documentação G"),
			Equipment(id: UUID(), name: "Equipamento 8", serial_number: "Tipo D", brand: "123456", model: "Marca F", type: "Modelo D", doc: "Documentação H"),
			Equipment(id: UUID(), name: "Equipamento 9", serial_number: "Tipo E", brand: "123456", model: "Marca G", type: "Modelo E", doc: "Documentação I"),
			Equipment(id: UUID(), name: "Equipamento 10", serial_number: "Tipo E", brand: "123456", model: "Marca H", type: "Modelo E", doc: "Documentação J"),
			Equipment(id: UUID(), name: "Equipamento 11", serial_number: "Tipo F", brand: "123456", model: "Marca I", type: "Modelo F", doc: "Documentação K"),
			Equipment(id: UUID(), name: "Equipamento 12", serial_number: "Tipo F", brand: "123456", model: "Marca J", type: "Modelo F", doc: "Documentação L"),
			Equipment(id: UUID(), name: "Equipamento 13", serial_number: "Tipo G", brand: "123456", model: "Marca K", type: "Modelo G", doc: "Documentação M"),
			Equipment(id: UUID(), name: "Equipamento 14", serial_number: "Tipo G", brand: "123456", model: "Marca L", type: "Modelo G", doc: "Documentação N"),
			Equipment(id: UUID(), name: "Equipamento 15", serial_number: "Tipo H", brand: "123456", model: "Marca M", type: "Modelo H", doc: "Documentação O"),
			Equipment(id: UUID(), name: "Equipamento 16", serial_number: "Tipo H", brand: "123456", model: "Marca N", type: "Modelo H", doc: "Documentação P"),
			Equipment(id: UUID(), name: "Equipamento 17", serial_number: "Tipo I", brand: "123456", model: "Marca O", type: "Modelo I", doc: "Documentação Q"),
			Equipment(id: UUID(), name: "Equipamento 18", serial_number: "Tipo I", brand: "123456", model: "Marca P", type: "Modelo I", doc: "Documentação R"),
		]
	}
}

struct EquipmentListView: View {
	let type: String
	let equipments: [Equipment]
	
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		NavigationView {
			List {
				ForEach(equipments) { equipment in
					NavigationLink(destination: EquipmentDetailView(equipment: equipment)) {
						EquipmentRowView(equipment: equipment)
					}
				}
			}
			.navigationTitle(type)
			.navigationBarItems(leading: Button(action: {
				presentationMode.wrappedValue.dismiss()
			}) {
				Text("Voltar")
			})
			.onAppear {
				debugPrint("Equipments for type \(type): \(equipments)")
			}
		}
	}
}

struct EquipmentRowView: View {
	let equipment: Equipment
	
	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(equipment.name)
				.foregroundColor(.primary)
				.font(.title2)
		}
	}
}
