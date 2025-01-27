import Foundation

final class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var errorMessage: String? = nil
    
    private var currentPage = 1
    private let productService: ProductServiceProtocol
    private var task: Task<Void, Never>? = nil
    
    init(productService: ProductServiceProtocol = ProductService()) {
           self.productService = productService
    }
    
    @MainActor
    func loadProducts(reset: Bool = false) {
        if reset {
            cancelLoading()
            currentPage = 1
            products = []
            errorMessage = nil 
        }

        task = Task {
            do {
                let newProducts = try await productService.fetchProducts(page: currentPage)
                self.products.append(contentsOf: newProducts)
                self.currentPage += 1
            } catch {
                self.errorMessage = "Ошибка загрузки данных. Попробуйте снова."
            }
        }
    }
    
    //Pagination
    @inlinable
    func loadMoreProducts(currentItem product: Product) {
        let thresholdIndex = self.products.index(self.products.endIndex, offsetBy: -5)
        if products[thresholdIndex].id == product.id {
            Task {
                await loadProducts()
            }
        }
    }
    
    func cancelLoading() {
        task?.cancel()
    }
}
