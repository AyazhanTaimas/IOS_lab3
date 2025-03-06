import SwiftUI

struct Hero: Decodable {
    let name: String
    let images: Image
    let powerstats: PowerStats
    let appearance: Appearance
    
    var imageUrl: URL? {
        URL(string: images.md)
    }
    
    var randomHeight: String {
        appearance.height.randomElement() ?? "Unknown"
    }
    
    var randomWeight: String {
        appearance.weight.randomElement() ?? "Unknown"
    }
    
    struct Image: Decodable {
        let md: String
    }
    
    struct PowerStats: Decodable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }
    
    struct Appearance: Decodable {
        let gender: String
        let race: String?
        let height: [String]
        let weight: [String]
        let eyeColor: String
        let hairColor: String
    }
}

final class ViewModel: ObservableObject {
    @Published var selectedHero: Hero?
    
    // MARK: - Methods
    func fetchHero() async {
        guard
            let url = URL(string: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json")
        else {
            return
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let heroes = try JSONDecoder().decode([Hero].self, from: data)
            let randomHero = heroes.randomElement()

            await MainActor.run {
                selectedHero = randomHero
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
}
