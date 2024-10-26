import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(page: Int) async throws -> [Product]
}

class ProductService: ProductServiceProtocol {
    func fetchProducts(page: Int) async throws -> [Product] {
        let url = URL(string: "https://dummyjson.com/products?limit=20&skip=\((page - 1) * 20)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductResponse.self, from: data)
        return response.products
    }
}

struct ProductResponse: Codable {
    let products: [Product]
}
