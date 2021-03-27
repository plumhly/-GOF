/*:
 # 责任链 - Chain Of Responsibility
 
 ## 意图
 使多个对象都有机会处理请求,从而避免请求的发送者和接收者之间的耦合关系。将这些对象连成一条链,并沿着这条链传递该请求,直到有一个对象处理它为止。
 
 ## 动机
 考虑一个图形用户界面中的上下文有关的帮助机制。用户在界面的任一部分上点击就可以得到帮助信息,所提供的帮助依赖于点击的是界面的哪一部分以及其上下文。例如,对话框中的按钮的帮助信息就可能和主窗口中类似的按钮不同。如果对那一部分界面没有特定的帮助信息,那么帮助系统应该显示一个关于当前上下文的较一般的帮助信息、一比如说,整个对话框。
 
 Chain of Responsibilityi模式告诉我们应该怎么做。这一模式的想法是,给多个对象处理一个请求的机会,从而解耦发送者和接受者。该请求沿对象链传递直至其中一个对象处理它,如下图所示。
 ![](1.png)
 
 从第一个对象开始,链中收到请求的对象要么亲自处理它,要么转发给链中的下一个候选者。提交请求的对象并不明确地知道哪一个对象将会处理它一我们说该请求有一个隐式的接收者( implicit receiver）。
 
 交互图如下:
 ![](2.png)
 
 在这个例子中,既不是 aprintbutton也不是 aprint Dialog处理该请求;它一直被传递给anApplication, anApplication处理它或忽略它。提交请求的客户不直接引用最终响应它的对象要沿链转发请求,并保证接收者为隐式的( implicit),每个在链上的对象都有一致的处理请求和访问链上**后继者**的接口。
 
 最后的设计图如下：
 ![](3.png)
 
 ## 适用性
 * 有多个的对象可以处理一个请求,哪个对象处理该请求运行时刻自动确定。
 * 你想在不明确指定接收者的情况下,向多个对象中的一个提交一个请求。
 * 可处理一个请求的对象集合应被动态指定。
 
 ## 结构
 ![](4.png)
 
 ## 参与者
 -- Handler(如HelpHandler)
 * 定义一个处理请求的接口
 * (可选)实现后继链。
 
 -- Concretehandler(如Printbutton和PrintDialog)
 * 处理它所负责的请求可访问它的后继者。
 * 如果可处理该请求,就处理之;否则将该请求转发给它的后继者。
 
 -- Client
 * 向链上的具体处理者( Concretehandler)对象提交请求。
 
 ## 协作
 当客户提交一个请求时,请求沿链传递直至有一个ConcreteHandler对象负责处理它。
 
 ## 效果
 Responsibility链有下列优点和缺点：
 1)降低耦合度该模式使得一个对象无需知道是其他哪一个对象处理其请求。对象仅需知道该请求会被“正确”地处理。接收者和发送者都没有对方的明确的信息,且链中的对象不需知道链的结构。
 2)增强了给对象指派职责( Responsibility)的灵活性当在对象中分派职责时,职责链给你更多的灵活性。你可以通过在运行时刻对该链进行动态的增加或修改来增加或改变处理一个请求的那些职责。
 你可以将这种机制与静态的特例化处理对象的继承机制结合起来使用。
 3)不保证被接受既然一个请求没有明确的接收者,那么就不能保证它一定会被处理该请求可能一直到链的末端都得不到处理。一个请求也可能因该链没有被正确配置而得不到处理。
 
 ## 实现
 下面是在职责链模式中要考虑的实现问题
 1)实现后继者链有两种方法可以实现后继者链。
    a)定义新的链接(通常在 Handler中定义,但也可由 Concretehandlers来定义)。
    b)使用已有的链接。当已有的链接能够支持你所需的链时,完全可以使用它们。这样你不需要明确定义链接而且可以节省空间。但如果该结构不能反映应用所需的职责链,那么你必须定义额外的链接。
 2)连接后继者如果没有已有的引用可定义一个链,那么你必须自己引入它们。这种情况下 Handler不仅定义该请求的接口,通常也维护后继链接。这样 Handler就提供了Handlerequest的缺省实现: Handlerequest向后继者(如果有的话)转发请求。
 
 3)表示请求可以有不同的方法表示请求。最简单的形式,比如在 Handlehelpl的例子中, 请求是一个硬编码的(hard-coded)操作调用。这种形式方便而且安全,但你只能转发 Handler 类定义的固定的一组请求。
 
 另一选择是使用一个处理函数,这个函数以一个请求码(如一个整型常数或一个字符串)为参数。这种方法支持请求数目不限。唯一的要求是发送方和接受方在请求如何编码问题上应达成一致。
 
 这种方法更为灵活,但它需要用条件语句来区分请求代码以分派请求。另外,无法用类型安全的方法来传递请求参数,因此它们必须被手工打包和解包。显然,相对于直接调用个操作来说它不太安全。
 
 为解决参数传递问题,我们可使用独立的请求对象来封装请求参数。 Request?类可明确地描述请求,而新类型的请求可用它的子类来定义。这些子类可定义不同的请求参数。处理者必须知道请求的类型(即它们正使用哪一个 Request子类)以访问这些参数。
 
 
 
 ## 相关模式
 1. 职责链常与 Composite(4.3)一起使用。这种情况下,一个构件的父构件可作为它的后继。
 
 
 ## 其他知识点
 
 */


import Cocoa

enum Type {
    case print, help, keyMap
}

protocol Handler: class {
    init(next: Handler?)
    func dealRequest(type: Type)
    var nextHandler: Handler? {get set}
}


class PrintHanlder: Handler {
    required init(next: Handler?) {
        nextHandler = next
    }
    
    var nextHandler: Handler?
    
    func dealRequest(type: Type) {
        if type == Type.print {
            print("PrintHanlder My Job")
        } else {
            nextHandler?.dealRequest(type: type)
        }
    }

}

class HelpHanlder: Handler {
    required init(next: Handler?) {
        nextHandler = next
    }
    
    var nextHandler: Handler?
    
    func dealRequest(type: Type) {
        if type == Type.help {
            print("HelpHanlder My Job")
        } else {
            nextHandler?.dealRequest(type: type)
        }
    }

}

class KeymapHanlder: Handler {
    required init(next: Handler?) {
        nextHandler = next
    }
    
    var nextHandler: Handler?
    
    func dealRequest(type: Type) {
        if type == Type.keyMap {
            print("KeymapHanlder My Job")
        } else {
            nextHandler?.dealRequest(type: type)
        }
    }

}

let list = PrintHanlder(next: HelpHanlder(next: KeymapHanlder(next: nil)))
list.dealRequest(type: .keyMap)
