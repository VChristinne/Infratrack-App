import SwiftUI

struct AddEquipmentView: View {
    @Environment(\.dismiss) var dismiss
    let data = EquipmentDataManager.shared
    
    @State private var name: String = ""
    @State private var serialNumber: String = ""
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var type: String = ""
    @State private var doc: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações")) {
                    TextField("Nome", text: $name)
                    TextField("Número de Série", text: $serialNumber)
                    TextField("Marca", text: $brand)
                    TextField("Modelo", text: $model)
                    TextField("Tipo", text: $type)
                    TextField("Documentação", text: $doc)
                }
            }
            .navigationTitle("Novo equipamento")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancelar") {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Salvar") {
						saveEquipment()
					}
					.disabled(name.isEmpty || type.isEmpty)
				}
			}
        }
    }
    
    private func saveEquipment() {
        let newEquipment = Equipment(
            id: UUID(),
            name: name,
            serial_number: serialNumber,
            brand: brand,
            model: model,
            type: type,
            doc: doc
        )
        data.addEquipment(newEquipment)
        dismiss()
    }
}
