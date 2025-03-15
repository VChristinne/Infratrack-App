import SwiftUI

struct TrackingView: View {
	@ObservedObject private var trackingManager = TrackingManager.shared
	
	@State private var inspections: [Inspection] = []
	@State private var equipments: [Equipment] = []
	@State private var employees: [Employee] = []
	@State private var showForm = false
	
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					showForm.toggle()
				}) {
					Label("Manutenção", systemImage: "plus")
				}
				.labelStyle(.iconOnly)
				.buttonStyle(.borderless)
				
				Spacer()
			}
			.padding(.horizontal)
			
			List {
				ForEach(trackingManager.inspections) { inspection in
					VStack(alignment: .leading) {
						Text("**Equipamento**: \(inspection.equipment.name)")
						Text("**Responsável**: \(inspection.employee.name)")
						Text("**Status**: \(inspection.status.rawValue)")
						Text("**Data**: \(formattedDate(from: inspection.date))")
					}
					.swipeActions(edge: .trailing, allowsFullSwipe: false) {
						Button(role: .destructive) {
							if let index = trackingManager.inspections.firstIndex(where: { $0.id == inspection.id }) {
								trackingManager.inspections.remove(at: index)
							}
						} label: {
							Label("Delete", systemImage: "trash")
						}
					}
				}
			}
		}
		.sheet(isPresented: $showForm) {
			InspectionFormView(
				inspection: .constant(inspections),
				equipments: .constant(equipments),
				employees: .constant(employees),
				types: .constant(Metadata.Category.allCases),
				status: .constant(Metadata.Status.allCases),
				trackingManager: trackingManager
			)
		}
		.onAppear {
			fetchEquipments()
			fetchEmployees()
		}
	}
	
		// MARK: - FETCH DATA
	func fetchEquipments() {
		equipments = EquipmentManager.shared.fetchEquipments()
	}
	
	func fetchEmployees() {
		employees = EmployeeManager.shared.fetchEmployees()
	}
	
		// MARK: - DATE FORMATTING
	func formattedDate(from date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .short
		return formatter.string(from: date)
	}
}
