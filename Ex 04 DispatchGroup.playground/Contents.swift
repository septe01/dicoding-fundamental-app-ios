import UIKit

var greeting = "DispatchGroup"

func task1(dispatchGroup: DispatchGroup) {
    let queue = DispatchQueue(label: "septe")
    
    queue.async {
        sleep(1)
        print("task one executed")
        dispatchGroup.leave()
    }
}

func task2(dispatchGroup: DispatchGroup) {
    DispatchQueue.global().async {
        sleep(2)
        print("task two executed")
        dispatchGroup.leave()
    }
}

func task3(dispatchGroup: DispatchGroup) {
    DispatchQueue.main.async {
        print("task tree executed")
        dispatchGroup.leave()
    }
}


let dispatchGroup = DispatchGroup()

dispatchGroup.enter()
task1(dispatchGroup: dispatchGroup)

dispatchGroup.enter()
task2(dispatchGroup: dispatchGroup)

dispatchGroup.enter()
task3(dispatchGroup: dispatchGroup)

dispatchGroup.notify(queue: DispatchQueue.main, execute: {
    print("all task finished")
})
