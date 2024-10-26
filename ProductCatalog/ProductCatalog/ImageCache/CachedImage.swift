import SwiftUI

// Component to display an image with caching support
struct CachedImage: View {
    @StateObject private var manager = CachedImageManager()
    let url: String
    
    var body: some View {
        Group {
            switch manager.image {
            case .some(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
            case .none:
                ProgressView()
                    .frame(width: 64, height: 64)
            }
        }
        .task {
            await manager.load(url)
        }
    }
}
