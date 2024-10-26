import SwiftUI

// Manager that loads and caches the image
final class CachedImageManager: ObservableObject {
    @Published var image: UIImage? = nil
    private let cache = ImageCache.shared
    
    //load Image
    @MainActor
    func load(_ stringURL: String) async {
        // Check if the image is already cached
        if let cachedData = cache.object(forKey: stringURL as NSString),
           let cachedImage = UIImage(data: cachedData) {
            image = cachedImage
            return
        }
        
        // If not cached, download the image from the network
        do {
            let data = try await fetchImageData(from: stringURL)
            if let downloadedImage = UIImage(data: data) {
                image = downloadedImage
                cache.set(object: data as NSData, forKey: stringURL as NSString)
            }
        } catch {
            print("Failed to load image: \(error)")
        }
    }
    
    // Asynchronously fetch image data from a URL
    private func fetchImageData(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
