import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager = FavoritesManager.shared

    var body: some View {
        Text("Favorites")
            .font(.title)
            .bold()
            List {
                ForEach(favoritesManager.favorites, id: \.self) { grocery in
                    HStack {
                        NavigationLink(destination: DetailsView(grocery: grocery)) {
                            HStack {
                                AsyncImage(url: URL(string: grocery.imageURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(grocery.name)
                                        .font(.headline)
                                    Text(String(format: "$%.2f", grocery.price))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    removeFavorite(grocery)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }

    private func removeFavorite(_ item: GroceryItem) {
        favoritesManager.removeFavorite(item)
    }
}
