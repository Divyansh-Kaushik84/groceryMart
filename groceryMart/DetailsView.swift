import SwiftUI

struct DetailsView: View {
    var grocery: GroceryItem
    @State private var isFavorite = false
    @ObservedObject private var favoritesManager = FavoritesManager.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                // Header Section
                AsyncImage(url: URL(string: grocery.imageURL)) { image in
                    image
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/2)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 16)

                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(grocery.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom, 4)
                            Spacer()
                            Text("\(grocery.weight)g")
                                .font(.title2)
                                .padding(.bottom, 4)
                        }

                        HStack {
                            Text(grocery.category)
                                .font(.title2)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "$%.2f", grocery.price))
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                }

                // Description Section
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.title2)
                        .padding().bold()
                    Text(grocery.description)
                        .font(.title2)
                        .padding()
                        .bold()
                }

                // Nutritional Information
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nutritional Information")
                        .font(.headline)
                        .padding(.bottom, 4)

                    HStack {
                        Label("Protein", systemImage: "flame")
                        Spacer()
                        Text(String(format: "%.1f g", grocery.protein))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Label("Calories", systemImage: "bolt.fill")
                        Spacer()
                        Text("\(grocery.calories)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Label("Fat", systemImage: "drop.fill")
                        Spacer()
                        Text(String(format: "%.1f g", grocery.fat))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Label("Sugar", systemImage: "leaf.fill")
                        Spacer()
                        Text(String(format: "%.1f g", grocery.sugar))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Label("Weight", systemImage: "scalemass.fill")
                        Spacer()
                        Text(String(format: "%d g", grocery.weight))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 5)

                // Add To Favorites Button
                HStack{
                    Spacer()
                    Button(action: toggleFavorite) {
                        Text(isFavorite ? "Remove From Favorites" : "Add To Favorites")
                            .foregroundColor(.white)
                            .bold()
                            .font(.title2)
                            .padding()
                            .background(isFavorite ? Color.purple.cornerRadius(25).shadow(color: .black, radius: 5) : Color.orange.cornerRadius(25).shadow(color: .black, radius: 10))
                    }
                    Spacer()

                }
            }
            .edgesIgnoringSafeArea(.top)
            .padding()
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isFavorite = favoritesManager.favorites.contains(grocery)
        }
    }

    private func toggleFavorite() {
        if isFavorite {
            favoritesManager.removeFavorite(grocery)
        } else {
            favoritesManager.addFavorite(grocery)
        }
        isFavorite.toggle()
    }
}
