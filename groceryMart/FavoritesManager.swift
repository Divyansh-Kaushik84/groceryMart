import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    private let favoritesKey = "favorites"

    @Published var favorites: [GroceryItem] = []

    static let shared = FavoritesManager()

    private init() {
        self.favorites = getFavorites()
    }

    func getFavorites() -> [GroceryItem] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        do {
            let items = try JSONDecoder().decode([GroceryItem].self, from: data)
            return items
        } catch {
            print("Failed to decode favorites: \(error)")
            return []
        }
    }

    func addFavorite(_ item: GroceryItem) {
        if !favorites.contains(item) {
            favorites.append(item)
            saveFavorites()
        }
    }

    func removeFavorite(_ item: GroceryItem) {
        if let index = favorites.firstIndex(of: item) {
            favorites.remove(at: index)
            saveFavorites()
        }
    }

    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Failed to encode favorites: \(error)")
        }
    }
}
