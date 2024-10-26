import SwiftUI

struct ProductView: View {
    let product: Product
    
   var body: some View {
       HStack {
           CachedImage(url: product.thumbnail)

            VStack(alignment: .leading) {
                Text(product.title)
                   .font(.headline)
                   .lineLimit(2)
                
                Text("$\(product.price, specifier: "%.2f")")
                   .font(.subheadline)
                   .foregroundColor(.secondary)
                
                Text("В наличии: \(product.stock)")
                   .font(.caption)
                   .foregroundColor(.green)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}
