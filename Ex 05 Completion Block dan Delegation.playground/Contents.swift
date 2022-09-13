import UIKit

var greeting = "Completion Block dan Delegation"


func expensiveTask(data: String, completion: @escaping (String) -> Void) {
    let queue = DispatchQueue(label: "septe")
    
    queue.async {
        print("processing data")
        sleep(2) // delay 2 detik
        completion("Processing \(data) is finished")
    }
}

let mainQueue = DispatchQueue(label: "mainQueue", qos: .userInteractive)

mainQueue.async {
    expensiveTask(data: "get User", completion: {
        result in print("result \(result)")
    })

    print("main queue run")
}


//Selain menggunakan Completion Block, bisa juga Anda gunakan Delegation untuk mencapai hasil yang sama.
//
// MARK: Delegation
// Delegation adalah sebuah pola di mana sebuah object dapat berinteraksi dengan object lain dengan menggunakan protocol. Dalam bahasa pemrograman lain protocol ini mempunyai fungsi yang hampir mirip dengan interface

protocol TaskDelegate {
    func taskFinished(result: String)
}

struct Task {
    var delegate: TaskDelegate?

    func expensiveTask(data: String) {
        let queue = DispatchQueue(label: "delegate")

        queue.async {
            print("processing \(data)")
            sleep(2)
            delegate?.taskFinished(result: "processing \(data) finished")
        }
    }
}

struct Main: TaskDelegate {
   
    func run() {
        let mainQueue = DispatchQueue (label: "mainQueue", qos: .userInteractive)
        mainQueue.async {
            var task = Task()
            task.delegate = self
            task.expensiveTask(data: "get User")
            print("main queue run")
        }
    }
    
    func taskFinished(result: String) {
        print(result)
    }
    
}


let main = Main()
main.run()
