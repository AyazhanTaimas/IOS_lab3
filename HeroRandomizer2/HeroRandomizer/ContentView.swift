import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if let hero = viewModel.selectedHero {
                VStack(spacing: 16) {
                    AsyncImage(url: hero.imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .cornerRadius(12)
                        case .failure:
                            Color.red
                                .frame(height: 300)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(16)
                    
                    Text(hero.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    HStack() {
                        VStack {
                            Text("🧠 Intelligence: ")
                            Text("💪 Strength: ")
                            Text("⚡ Speed: ")
                            Text("🏋️‍♂️ Durability: ")
                            Text("✊ Power: ")
                            Text("🎯 Combat: ")
                            Text("🚻 Gender: ")
                            Text("🧬 Race: ")
                            Text("📏 Height: ")
                            Text("⚖️ Weight: ")
                            Text("👁 Eye Color: ")
                            Text("💇 Hair Color: ")
                        }
                        VStack {
                            Text("\(hero.powerstats.intelligence)")
                            Text("\(hero.powerstats.strength)")
                            Text("\(hero.powerstats.speed)")
                            Text("\(hero.powerstats.durability)")
                            Text("\(hero.powerstats.power)")
                            Text("\(hero.powerstats.combat)")
                            Text("\(hero.appearance.gender)")
                            Text("\(hero.appearance.race)")
                            Text("\(hero.randomHeight)")
                            Text("\(hero.randomWeight)")
                            Text("\(hero.appearance.eyeColor)")
                            Text("\(hero.appearance.hairColor)")
                        }
                    }
                    .font(.body)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                }
                .padding()
            } else {
                Text("Нажмите на кнопку, чтобы получить героя!")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.fetchHero()
                }
            }) {
                Text("🎲 Roll Hero")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    let viewModel = ViewModel()
    ContentView(viewModel: viewModel)
}
