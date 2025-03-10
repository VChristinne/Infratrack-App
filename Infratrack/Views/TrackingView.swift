import SwiftUI

struct TrackingView: View {
    var body: some View {
        NavigationStack {
            Text("Tracking")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Rastreamento")
        }
    }
}
