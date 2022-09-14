import UIKit

var greeting = "Operation Queue"

enum Color: String {
    case red = "red"
    case blue = "blue"
}

let count = 5

func show(color: Color, count: Int) {
    for _ in 1...count {
        print(color.rawValue)
    }
}

//show(color: .blue, count: count)

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2

let operation1 = BlockOperation(block: {
    show(color: .red, count: count)
})
operation1.qualityOfService = .userInteractive

let operation2 = BlockOperation(block: {
    show(color: .blue, count: count)
})


operation1.completionBlock = {
    print("operation 1 complited")
}

operation2.completionBlock = {
    print("operation 2 complited")
}

//Di sini kita mengharuskan operation2 dijalankan setelah operation1 selesai.
operation2.addDependency(operation1)


//tambahkan operation ke dalam OperationQueue
queue.addOperation(operation1)

queue.addOperation(operation2)



