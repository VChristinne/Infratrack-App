import SwiftUI

struct DocumentView: View {
	@State private var fileName = "Nenhum arquivo selecionado"
	@State private var showFileImporter = false
	
	var body: some View {
		VStack(spacing: 25) {
			Text(fileName)
			
			Button {
				showFileImporter = true
			} label: {
				Label("Abrir explorador de arquivos", systemImage: "folder")
					.labelStyle(.titleOnly)
			}
		}
		.fileImporter(
			isPresented: $showFileImporter,
			allowedContentTypes: [.pdf],
			allowsMultipleSelection: true
		) { result in
			switch result {
				case .success(let files):
					files.forEach { file in
						let gotAccess = file.startAccessingSecurityScopedResource()
						if !gotAccess { return }
						
						fileName = file.lastPathComponent
						file.stopAccessingSecurityScopedResource()
					}
				case .failure(let error):
					fileName = "Erro: \(error.localizedDescription)"
			}
		}
	}
}
