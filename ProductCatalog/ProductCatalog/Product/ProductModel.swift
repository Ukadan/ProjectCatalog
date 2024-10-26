import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let stock: Int
    let thumbnail: String
}
