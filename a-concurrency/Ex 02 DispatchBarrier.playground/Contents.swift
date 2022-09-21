import UIKit

class ThreadSafeArray{
    let isolation = DispatchQueue(label: "septe", attributes: .concurrent)
    
    private var _array: [Int] = [1,2,3]
    
    var array: [Int] {
        get{
            return isolation.sync{
                _array
            }
        }
        set{
            isolation.async(flags: .barrier){
                self._array = newValue
            }
        }
    }
    
    
}

let test = ThreadSafeArray()
test.array[0] = 2
test.array





