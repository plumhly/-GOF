/*:
 # 中介者 - Mediator  -- 对象行为型模式
 
 ## 意图
 用一个中介对象来封装一系列的对象交互。中介者使各对象不需要显式地相互引用,从而使其耦合松散,而且可以独立地改变它们之间的交互。
 
 ## 动机
 面向对象设计鼓励将行为分布到各个对象中。这种分布可能会导致对象间有许多连接。在最坏的情况下,每一个对象都知道其他所有对象。
 虽然将一个系统分割成许多对象通常可以增强可复用性,但是对象间相互连接的激增又会降低其可复用性。大量的相互连接使得一个对象似乎不太可能在没有其他对象的支持下工作系统表现为一个不可分割的整体。而且,对系统的行为进行任何较大的改动都十分困难, 因为行为被分布在许多对象中。结果是,你可能不得不定义很多子类以定制系统的行为。
 
 例如,考虑一个图形用户界面中对话框的实现。
 
 ![](1.png)
 
 通常对话框中的窗口组件间存在依赖关系。例如,当一个特定的输入域为空时,某个按钮不能使用;在称为列表框的一列选项中选择一个表目可能会改变一个输入域的内容;
 
 可以通过将集体行为封装在一个单独的中介者(Mediator)对象中以避免这个问题。中介者负责控制和协调一组对象间的交互。中介者充当一个中介以使组中的对象不再相互显式引用。
 这些对象仅知道中介者,从而减少了相互连接的数目。
 
 ![](2.png)
 
 下面的交互图说明了各对象如何协作处理一个列表框中选项的变化。
 
 ![](3.png)

 ## 适用性
 在下列情况下使用中介者模式:
 * 一组对象以定义良好但是复杂的方式进行通信。产生的相互依赖关系结构混乱且难以理解。
 * 个对象引用其他很多对象并且直接与这些对象通信,导致难以复用该对象。
 * 想定制一个分布在多个类中的行为,而又不想生成太多的子类。

 ## 结构
 ![](4.png)
 
 ## 参与者
 -- Mediator(中介者,如DialogDirector)
 * 中介者定义一个接口用于与各同事(Colleague)对象通信。
 
 -- Concretemediator(具体中介者,如 FontdialogDirector)
 * 具体中介者通过协调各同事对象实现协作行为。
 * 了解并维护它的各个同事。
 
 -- Colleague clas(同事类,如 Listbox, EntryField)
 * 每一个同事类都知道它的中介者对象。
 * 每一个同事对象在需与其他的同事通信的时候,与它的中介者通信。
 
 ![](5.png)
 
 ## 协作
 同事向一个中介者对象发送和接收请求。中介者在各同事间适当地转发请求以实现协作行为。
 
 ## 效果
 中介者模式有以下优点和缺点:
 1) 减少了子类生成 Mediator?将原本分布于多个对象间的行为集中在一起。改变这些行为只需生成 Meditator的子类即可。这样各个 Colleague类可被重用。
 2) 它将各 Colleague解耦 Mediator有利于各 Colleague间的松耦合.你可以独立的改变和复用各 Colleague类和 Mediator类。
 3) 它简化了对象协议用 Mediator和各 Colleague间的一对多的交互来代替多对多的交互。对多的关系更易于理解、维护和扩展。
 4) 它对对象如何协作进行了抽象将中介作为一个独立的概念并将其封装在一个对象中, 使你将注意力从对象各自本身的行为转移到它们之间的交互上来。这有助于弄清楚一个系统中的对象是如何交互的。
 5) 它使控制集中化中介者模式将交互的复杂性变为中介者的复杂性。因为中介者封装了协议,它可能变得比任一个 Colleague都复杂。这可能使得中介者自身成为一个难于维护的
 
 ## 实现
 下面是与中介者模式有关的一些实现问题:
 1) 忽略抽象的Mediator类当各Colleague仅与ー个Mediator一起工作时,没有必要定义一个抽象的Mediator类。 Mediator类提供的抽象耦合已经使各 Colleague可与不同的 Mediator子类起工作,反之亦然。
 2) Colleague-Mediator通信当一个感兴趣的事件发生时, Colleague必须与其Mediator通信。
    * 一种实现方法是使用 Observer(5.7模式,将 Mediator实现为一个Observer, 各Colleague作为Subject,一旦其状态改变就发送通知给Mediator。Mediator作出的响应是将状态改变的结果传播给其他的Colleague。
    * 另一个方法是在Mediator中定义一个特殊的通知接口,各Colleague在通信时直接调用该接口。当与Mediator通信时, Colleague将自身作为一个参数传递给Mediator,使其可以识别发送者。
 
 
 ## 相关模式
 * Facade(4.5)与中介者的不同之处在于它是对一个对象子系统进行抽象,从而提供了一个更为方便的接口。它的协议是单向的,即Facade对象对这个子系统类提出请求,但反之则不行。
 相反,Mediator提供了各Colleague对象不支持或不能支持的协作行为,而且协议是多向的。
 * Colleague可使用 Observer(5.7)模式与 Mediator通信。

 ## 其他知识点
 
 */


import Cocoa

protocol Mediator {
    /// Style 1
    func showColleague1()
    func showColleague2()
    
    /// Style 2
//    func show(c: Colleague)
}

struct ConcreateMeidator: Mediator {
    
    var c1: Colleague1?
    var c2: Colleague2?
    
    func showColleague1() {
        c2?.hide()
        c1?.show()
    }
    
    func showColleague2() {
        c1?.hide()
        c2?.show()
    }
}

protocol Colleague {
    init(mediator: Mediator)
    func show()
}

struct Colleague1: Colleague {
    let mediator: Mediator
    init(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func show() {
        mediator.showColleague1()
    }
    
    func hide() {
        
    }
}

struct Colleague2: Colleague {
    let mediator: Mediator
    init(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func show() {
        mediator.showColleague2()
    }
    
    func hide() {
        
    }
}

var mediator = ConcreateMeidator()
let c1 = Colleague1(mediator: mediator)
mediator.c1 = c1

let c2 = Colleague2(mediator: mediator)
mediator.c2 = c2

c1.show()
