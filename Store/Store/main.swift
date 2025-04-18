import Foundation

// MARK: - SKU Protocol
protocol SKU {
    var name: String { get }
    func price() -> Int
}

// MARK: - Item Class
class Item: SKU {
    let name: String
    private let itemPrice: Int

    init(_ name: String, _ price: Int) {
        self.name = name
        self.itemPrice = price
    }

    func price() -> Int {
        return itemPrice
    }
}

// MARK: - Receipt Class
class Receipt {
    private var scannedItems: [SKU] = []

    func addItem(_ item: SKU) {
        scannedItems.append(item)
    }

    func items() -> [SKU] {
        return scannedItems
    }

    func total() -> Int {
        return scannedItems.reduce(0) { $0 + $1.price() }
    }
    
    func output() -> String {
        var result = "Receipt:"
        for item in scannedItems {
            let formattedPrice = String(format: "$%.2f", Double(item.price()) / 100.0)
            result += "\n\(item.name): \(formattedPrice)"
        }
        result += "\n------------------"
        result += "\nTOTAL: \(String(format: "$%.2f", Double(total()) / 100.0))"
        return result
    }
}

// MARK: - Register Class
class Register {
    private var receipt = Receipt()

    func scan(_ item: SKU) {
        receipt.addItem(item)
    }

    func subtotal() -> Int {
        return receipt.total()
    }

    func total() -> Receipt {
        let finalReceipt = receipt
        receipt = Receipt()  // Reset for next customer
        return finalReceipt
    }
}
