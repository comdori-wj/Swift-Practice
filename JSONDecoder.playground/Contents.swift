import Foundation

struct GroceryProduct: Codable { // Codable 외부 표현으로 변환 할 수 있는 타입
    var name: String
    var points: Int
    var description: String?
}


let json = """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!


let decoder = JSONDecoder()
let product = try decoder.decode(GroceryProduct.self, from: json)


print(product.name) // Durian
print(product.points) // 600
print(product.description ?? "") // "A fruit with a distinctive scent."

