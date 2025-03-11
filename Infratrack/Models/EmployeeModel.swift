import Foundation

struct Employee: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let role: String
    let address: String
    let avatar: String
}
