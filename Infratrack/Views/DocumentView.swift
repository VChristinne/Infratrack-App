import SwiftUI

struct DocumentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Documentation")
                    .font(.largeTitle)
            }
            .navigationTitle("Documentação")
        }
    }
}
