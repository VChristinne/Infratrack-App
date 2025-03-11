import Foundation

struct Equipment: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let serial_number: String
    let brand: String
    let model: String
    let type: String
    let doc: String
}
