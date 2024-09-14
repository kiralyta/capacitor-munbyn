import Foundation

@objc public class CapacitorMunbyn: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
