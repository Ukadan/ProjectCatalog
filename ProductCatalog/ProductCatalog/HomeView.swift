import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.products) { product in
                            ProductView(product: product)
                                .padding(.horizontal, 16)
                                .onAppear() {
                                    viewModel.loadMoreProducts(currentItem: product)
                                }
                        }
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        VStack {
                            Text(errorMessage)
                                .foregroundColor(.red)
                            Button("Повторить загрузку") {
                                viewModel.loadProducts(reset: viewModel.products.isEmpty ? true : false)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    viewModel.loadProducts(reset: true)
                }
            }
            .onAppear {
                viewModel.loadProducts()
            }
        }
        .preferredColorScheme(.none) 
    }
}

#Preview {
    HomeView()
}
