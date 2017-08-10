import UIKit

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/*
 var i1 = 1, i2 = 1
 
 var fStrong = {
 i1 += 1
 i2 += 2
 }
 
 // 使用捕获列表，闭包内部会创建一个新的可用常量。如果没有指定常量修饰符，闭包将会简单地拷贝原始值到新的变量中，对于值类型和引用类型都是一样的。
 var fCopy = { [i1] in
 print(i1,i2)
 }
 
 fStrong()
 print(i1,i2) //打印结果是 2 和 3
 
 
 
 fCopy()  //打印结果是 1 和 3
 */
class aClass{
    var value = 1
}

var c1 = aClass()
var c2 = aClass()
/*
 
 unowned 引用使用的场景是，原始实例永远不会为 nil，闭包可以直接使用它，并且直接定义为显式解包可选值。当原始实例被析构后，在闭包中使用这个捕获值将导致崩溃。
 如果捕获原始实例在使用过程中可能为 nil ，必须将引用声明为 weak， 并且在使用之前验证这个引用的有效性。
 */
var fSpec = { [unowned c1, weak c2] in
    c1.value += 1
    if let c2 = c2 {
        c2.value += 1
    }
}

fSpec()
print(c1.value,c2.value) //Prints 2 and 2

/*
 有两个可能出现的场景：
 闭包和捕获对象的生命周期相同，所以对象可以被访问，也就意味着闭包也可以被访问。外部对象和闭包有相同的生命周期(比如：对象和它的父对象的简单返回引用）。在这种情况下，你应该把引用定义为 unowned。
 一个经典的案例是: [unowned self], 主要用在闭包中，这种闭包主要在他们的父节点上下文中做一些事情，没有在其他地方被引用或传递，不能作用在父节点之外。
 闭包的生命周期和捕获对象的生命周期相互独立，当对象不能再使用时，闭包依然能够被引用。这种情况下，你应该把引用定义为 weak，并且在使用它之前验证一下它是否为 nil（请不要对它进行强制解包).
 一个经典的案例是: [weak delegate = self.delegate!]，可以在某些使用闭包的场景中看到，闭包使用的是完全无关（生命周期独立）的代理对象。
 
 
 */


/*
 
 弱引用最常见的实现是，每次一个新的引用生成时，都会把每个弱引用和它指向的对象信息存储到一个附加表中。
 当没有任何强引用指向一个对象时，Swift 运行时会启动析构过程，但是在这之前，运行时会把所有相关的弱引用置为 nil 。弱引用的这种实现方式我们称之为”零和弱引用”。
 这种实现有实际的开销，考虑到需要额外实现的数据结构，需要确保在并发访问情况下，对这个全局引用结构所有操作的正确性。一旦析构过程开始了，在任何环境中，都不允许访问弱引用所指向的对象了。
 
 
 */

/*
 以前在 Objective-C 中，我们可以使用一个 NSObject 的实例方法，-performSelector:withObject:afterDelay: 来指定在若干时间后执行某个 selector。在 Swift 2 之前，如果你新建一个 Swift 的项目，并且试图使用这个方法 (或者这个方法的其他一切变形) 的话，会发现这个方法并不存在。在 Swift 2 中虽然这一系列 performSelector 的方法被加回了标准库，但是由于 Swift 中创建一个 selector 并不是一件安全的事情 (你需要通过字符串来创建，这在之后代码改动时会很危险)，所以最好尽可能的话避免使用这个方法。另外，原来的 performSelector: 这套东西在 ARC 下并不是安全的。ARC 为了确保参数在方法运行期间的存在，在无法准确确定参数内存情况的时候，“会将输入参数在方法开始时先进行 retain，然后在最后 release。而对于 performSelector: 这个方法我们并没有机会为被调用的方法指定参数，于是被调用的 selector 的输入有可能会是指向未知的垃圾内存地址，然后...HOHO，要命的是这种崩溃还不能每次重现，想调试？见鬼去吧..”
 
 “但是如果不论如何，我们都还想继续做延时调用的话应该怎么办呢？最容易想到的是使用 Timer 来创建一个若干秒后调用一次的计时器。但是这么做我们需要创建新的对象，和一个本来并不相干的 Timer 类扯上关系，同时也会用到 Objective-C 的运行时特性去查找方法等等，总觉着有点笨重。其实 GCD 里有一个很好用的延时调用我们可以加以利用写出很漂亮的方法来，那就是 asyncAfter。最简单的使用方法看起来是这样的：”
 
 “在这里我们可以稍微将它封装的好用一些，最好再加上取消的功能。在 iOS 8 中 GCD 得到了惊人的进化，现在我们可以通过将一个闭包封装到 DispatchWorkItem 对象中，然后对其发送 cancel，来取消一个正在等待执行的 block。取消一个任务这样的特性，这在以前是 NSOperation 的专利，但是现在我们使用 GCD 也能达到同样的目的了。这里我们不使用这个方式，而是通过捕获一个 cancel 标识变量来实现 delay call 的取消，整个封装也许有点长，但我还是推荐一读。大家也可以把它当作练习材料检验一下自己的 Swift 基础语法的掌握和理解的情况：”
 */

typealias Task = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    
    var closure: (()->Void)? = task
    var result: Task?
    
    let delayedClosure: Task = { cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    
    return result;
    
}

func cancel(_ task: Task?) {
    task?(true)
}

delay(2) {
    print("aa")
    
}

let task = delay(5) {
    print("5")
}


cancel(task)













