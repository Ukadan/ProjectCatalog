import Foundation

// Class for in-memory image caching
class ImageCache {
    typealias CacheType = NSCache<NSString, NSData>
    
    static let shared = ImageCache()
    
    private init() {}
    
    // Set cache limits
    private lazy var cache: CacheType = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
        return cache
    }()
    
    // Retrieve an object from the cache by key
    func object(forKey key: NSString) -> Data? {
        return cache.object(forKey: key) as? Data
    }
    
    // Store an object in the cache with a given key
    func set(object: NSData, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}
