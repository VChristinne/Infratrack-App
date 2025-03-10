import SwiftUI

struct DashboardView: View {
    @State private var isFocusOn: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
            }
            .navigationTitle("Dashboard")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
    }
}
