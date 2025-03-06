import Foundation

struct Hero: Codable, Identifiable {
    let id: Int
    let name: String
    let powerstats: PowerStats
    let biography: Biography
    let appearance: Appearance
    let images: Images
}

struct PowerStats: Codable {
    let intelligence, strength, speed, durability, power, combat: Int
}

struct Biography: Codable {
    let fullName, placeOfBirth: String
}

struct Appearance: Codable {
    let gender, race, height, weight: String
}

struct Images: Codable {
    let xs, sm, md, lg: String
}
