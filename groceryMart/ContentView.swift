import SwiftUI

struct ContentView: View {
    var groceryItems: [GroceryItem] {
        loadGroceryItems() ?? []
    }
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false){
                Text("Grocery Store")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5,x:5,y:5)
                    
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(groceryItems, id: \.self) { grocery in
                        NavigationLink(destination:DetailsView(grocery: grocery)){
                            SingleItemView(grocery: grocery)
                        }
                    }
                }
                .padding(.vertical)
                .navigationTitle("")
            }
            .navigationBarItems(trailing:NavigationLink(destination:FavoritesView())
                                {
                Image(systemName: "heart")
                    .foregroundColor(.white)
                    .bold()
                    .font(.title2)
            })
            .background(.orange)
        }
    }
}
struct SingleItemView:View {
    var grocery : GroceryItem
    var body: some View {
        VStack(alignment:.leading){
            VStack(alignment:.leading){
                AsyncImage(url: URL(string: grocery.imageURL)) { image in
                      image
                          .resizable()
                          .cornerRadius(20)
                          .frame(width: 175,height: 160)
                  } placeholder: {
                      ProgressView()
                  }
                  .padding(.bottom, 5)
                
                    HStack{
                        Text("\(grocery.weight) g")
                            .bold()
                            .padding(5)
                            .font(.caption).background{
                                Color.gray.opacity(0.2).cornerRadius(5)
                            }
                        Spacer()
                        Text(String(format: "$%.2f", grocery.price))

                            .font(.caption)
                    }
                    .padding(.horizontal,10)
            }
                    Text(grocery.name)
                        .font(.headline).fixedSize()
                        .padding(.horizontal,10)
                        .padding(.vertical)


        }.foregroundColor(.black)
        .frame(width:175,height: 250)
        .background{
            Color.white
        }
        .cornerRadius(20).shadow(color: .black, radius: 5)

    }
}
// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        SingleItemView(grocery: GroceryItem(id: "1", name: "Apple", category: "Fruit", price: 0, description: "juicy", protein: 0, calories: 0, fat: 0, sugar: 0, percentage: 0, weight: 0, imageURL: "https://i.pinimg.com/564x/f3/3a/51/f33a51d4fbd3f0dd77e9d6c91275889d.jpg", quantity: 2))
        ContentView()
    }
}
