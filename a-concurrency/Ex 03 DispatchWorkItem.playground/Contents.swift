import UIKit

var greeting = "DispatchWorkItem"

var value = 5
let workItem = DispatchWorkItem {
    value += 5
}

//workItem.perform()

let queue = DispatchQueue(label: "septe", qos: .utility)
queue.async(execute: workItem)

workItem.notify(queue: DispatchQueue.main) {
    print("final value \(value)")
}
