import UIKit

/*
 在 Swift 中有一类很有意思的写法，可以让我们不直接使用实例来调用这个实例上的方法，而是通过类型取出这个类型的某个实例方法的签名，然后再通过传递实例来拿到实际需要调用的方法。
 // Swift 中可以直接用 Type.instanceMethod 的语法来生成一个可以柯里化的方法。

 /*
 其实对于 Type.instanceMethod 这样的取值语句，实际上刚才
 let f = MyClass.method
 做的事情是类似于下面这样的字面量转换：
 let f = { (obj: MyClass) in obj.method }
 */
 
 */

class MyClass {
    func method0(number: Int) -> Int {
        return number
    }
    
    func method1(number: Int) -> Int {
        return number + 1
    }
    
    class func method1(number: Int) -> Int {
        return number
    }
    class func method1() -> Int {
        return 66
    }
}

let instance = MyClass()

let f0 = MyClass.method0

/*

 这种方法只适用于实例方法，对于属性的 getter 或者 setter 是不能用类似的写法的。另外，如果我们遇到有类型方法的名字冲突时 如果不加改动，MyClass.method 将取到的是类型方法，如果我们想要取实例方法的话，可以显式地加上类型声明加以区别。这种方式不仅在这里有效，在其他大多数名字有歧义的情况下，都能很好地解决问题：
 */

let f1: () -> (Int) = MyClass.method1

let f2:(MyClass) -> (Int) -> (Int) = MyClass.method1



