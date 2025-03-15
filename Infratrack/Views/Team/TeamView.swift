import SwiftUI

struct TeamView: View {
	@State private var employees: [Employee] = []
	
	let data = EmployeeManager.shared
	
	var body: some View {
		GeometryReader { geometry in
			let isPortrait = geometry.size.width < geometry.size.height
			let gridItems = [GridItem(.flexible()), GridItem(.flexible())] + (isPortrait ? [] : [GridItem(.flexible())])
			
			ScrollView {
				LazyVGrid(columns: gridItems, spacing: 12) {
					ForEach(employees) { employee in
						TeamCardView(employee: employee)
					}
				}
				.padding()
			}
			
			.onAppear {
				fetchEmployees()
			}
		}
	}
	
	func fetchEmployees() {
		employees = data.fetchEmployees()
	}
}
