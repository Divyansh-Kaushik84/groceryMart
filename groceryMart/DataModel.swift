import Foundation

struct GroceryItem: Codable, Hashable {
    let id: String
    let name: String
    let category: String
    let price: Double
    let description: String
    let protein: Double
    let calories: Int
    let fat: Double
    let sugar: Double
    let percentage: Double
    let weight: Int
    let imageURL: String 
    let quantity : Int

}

func loadGroceryItems() -> [GroceryItem]? {
    guard let url = Bundle.main.url(forResource : "grocery_items", withExtension: "json" ) else{
        print("Item not found")
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let items = try decoder.decode([GroceryItem].self, from: data)
        return items
    }
    catch{
        print("Error Decoding Json: \(error)")
        return nil
    }
}
