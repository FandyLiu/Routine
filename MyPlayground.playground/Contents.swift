import UIKit

/*
 /*
 @selector 是 OC 的关键字, 他可以将方法转换为 SEL 类型
 */
 
 // SEL 两种创建方法
 SEL ocMethod0 = @selector(callMe);
 SEL ocMethod1 = NSSelectorFromString(@"callMeWithParam:");
 // 可以通过 performSelector 来调用
 
 */

class SelectorTest: NSObject {
    var oneParam: Int = 0
    // private 只能在本类中调用 扩展也不行
    @objc fileprivate func privateMethod() {
        
    }
    
    func callMe() {
        
    }
    
    func callMe(with param: Any) {
        
    }
}

let test = SelectorTest()
/*
 “selector 其实是 Objective-C runtime 的概念，如果你的 selector 对应的方法只在 Swift 中可见的话 (也就是说它是一个 Swift 中的 private 方法)，在调用这个 selector 时你会遇到一个 unrecognized selector 错误：”
 // 'privateMethod' is inaccessible due to 'private' protection level
 */

let pM = test.responds(to: #selector(SelectorTest.privateMethod))
//Timer.scheduledTimer(timeInterval: 1, target: test, selector: #selector(SelectorTest.privateMethod), userInfo: nil, repeats: false)

/*
 检测是否有某个参数
 */
if test.responds(to: #selector(getter: SelectorTest.oneParam)) {
    print("test 中有 oneParam")
}


/*
 “但是，如果在同一个作用域中存在同样名字的两个方法，即使它们的函数签名不相同，Swift 编译器也不允许编译通过：”
 */
//let swiftMethod0 = #selector(callMe) // ambiguous use of 'callMe'
let swiftMethod0 = #selector((SelectorTest.callMe) as (SelectorTest) -> () -> ())
let swiftMethod1 = #selector(SelectorTest.callMe(with:))
/*
 https://github.com/apple/swift-evolution/blob/master/proposals/0022-objc-selectors.md
 let sel = #selector(((UIView.insertSubview(_:at:)) as (UIView) -> (UIView, Int) -> Void))
 */

print("aa")
