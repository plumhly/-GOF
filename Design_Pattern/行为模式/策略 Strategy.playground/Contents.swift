/*:
 # 策略 - Strategy  -- 对象行为型模式
 
 ## 意图
 定义一系列的算法,把它们一个个封装起来,并且使它们可相互替换。本模式使得算法可独立于使用它的客户而变化。
 
 ## 别名
 政策（Policy）
 
 ## 动机
 有许多算法可对一个正文流进行分行。将这些算法硬编进使用它们的类中是不可取的。
 我们可以定义一些类来封装不同的换行算法,从而避免这些向题。一个以这种方法封装的算法称为一个策略(strategy),如下图所示。
 
 ![](1.png)
 
 假设一个Composition类负责维护和更新一个正文浏览程序中显示的正文换行。换行策略不是Composition类实现的,而是由抽象的Compositor类的子类各自独立地实现的。
 Compositor各个子类实现不同的换行策略:
 * Simplecompositor实现一个简单的策略,它一次决定一个换行位置。
 * Texcompositor实现査找换行位置的TEX算法。这个策略尽量全局地优化换行,也就是,一次处理一段文字的换行。
 * ArrayCompositor实现一个策略,该策略使得每一行都含有一个固定数目的项。例如,用于对一系列的图标进行分行。
 
 Composition维护对Compositor对象的一个引用。一且Composition重新格式化它的正文,它就将这个职责转发给它的 Compositor)对象。Composition的客户指定应该使用哪一种Compositor的方式是直接将它想要的compositor装人 Compositione中。
 
 ## 适用性
 当存在以下情况时使用Strategy模式
 * 许多相关的类仅仅是行为有异。“策略”提供了一种用多个行为中的一个行为来配置一个类的方法。
 * 需要使用一个算法的不同变体。例如,你可能会定义一些反映不同的空间/时间权衡的算法。当这些变体实现为一个算法的类层次时[HO87,可以使用策略模式。
 * 算法使用客户不应该知道的数据。可使用策略模式以避免暴露复杂的、与算法相关的数据结构。
 * 一个类定义了多种行为,并且这些行为在这个类的操作中以多个条件语句的形式出现。将相关的条件分支移人它们各自的Strategy类中以代替这些条件语句。
 
 ## 结构
 ![](2.png)
 
 ## 参与者
 -- Strategy(策略,如Compositor)
 * 定义所有支持的算法的公共接口。 Context使用这个接口来调用某 Concretestrategy定义的算法。
 
 -- Concretestrategy(具体策略,如 SimpleCompositor, Texcompositor, ArrayCompositor)
 * 以Strategy接口实现某具体算法。
 
 -- Context(上下文,如Composition)
 * 用一个Concretestrategy对象来配置。
 * 维护一个对Strategy对象的引用。
 * 可定义一个接口来让Stategy访问它的数据。
 
 ## 协作
 * Strategy和Context相互作用以实现选定的算法。当算法被调用时, Context可以将该算法所需要的所有数据都传递给该Stategy。或者, Context可以将自身作为一个参数传递给Strategy操作。这就让Strategy在需要时可以回调Context。
 * Context将它的客户的请求转发给它的Strategy。客户通常创建并传递一个ConcreteStrategy对象给该Context:;这样,客户仅与Context交互。通常有一系列的Concretestrategy类可供客户从中选择。
 
 ## 效果
 Strategy模式有下面的一些优点和缺点:
 1) 相关算法系列。Strategy类层次为Context定义了一系列的可供重用的算法或行为。继承有助于析取出这些算法中的公共功能。
 2) 一个替代继承的方法。继承提供了另一种支持多种算法或行为的方法。你可以直接生成一个Context类的子类,从而给它以不同的行为。但这会将行为硬行编制到Context中,而将算法的实现与Contexte的实现混合起来,从而使 Context难以理解、难以维护和难以扩展,而且还不能动态地改变算法。最后你得到一堆相关的类,它们之间的唯一差别是它们所使用的算法或行为。将算法封装在独立的Strategy类中使得你可以独立于其 Context改变它,使它易于切换、易于理解、易于扩展。
 3) 消除了一些条件语句。Strategy模式提供了用条件语句选择所需的行为以外的另一种选择。当不同的行为堆砌在一个类中时,很难避免使用条件语句来选择合适的行为。将行为封装在一个个独立的 Strategy类中消除了这些条件语句。
 4) 实现的选择。Strategy模式可以提供相同行为的不同实现。客户可以根据不同时间/空间权衡取舍要求从不同策略中进行选择。
 5) 客户必须了解不同的Strategy。本模式有一个潜在的缺点,就是一个客户要选择一个合适的Strategy.就必须知道这些Strategy到底有何不同。此时可能不得不向客户暴露具体的实现问题。因此仅当这些不同行为变体与客户相关的行为时,才需要使用 Strategy模式。
 6) Strategy和Context:之间的通信开销。无论各个Concretestrategy实现的算法是简单还是复杂,它们都共享Strategy定义的接口。因此很可能某些 Concretestrategy不会都用到所有通过这个接口传递给它们的信息;简单的 Concretestrategy可能不使用其中的任何信息!这就意味着有时Context会创建和初始化一些永远不会用到的参数。如果存在这样问题;那么将需要在Strategy和Context之间更进行紧密的耦合。
 7) 增加了对象的数目Strategy增加了一个应用中的对象的数目。有时你可以将Strategy实现为可供各Context共享的无状态的对象来减少这一开销。任何其余的状态都由Context维护。
 Context在每一次对Strategy对象的请求中都将这个状态传递过去。共享的Stragey不应在各次调用之间维护状态。 Flyweight(4.6)模式更详细地描述了这一方法。
 
 ## 实现
 考虑下面的实现问题:
 1) 定义Strategy和 Context接ロ。 Strategy和Context接口必须使得 Concretestrategy能够有效的访问它所需要的 Contexte中的任何数据,反之亦然。一种办法是让 Context将数据放在参数中传递给 Strategy操作一也就是说,将数据发送给 Strategy。这使得 Strategy和Contexta解耦。但另一方面, Context可能发送一些Strategy不需要的数据。
 另一种办法是让Context将自身作为一个参数传递给Strategy,该 Strategy再显式地向该Context请求数据。或者, Strategy可以存储对它的Context的一个引用,这样根本不再需要传递任何东西。这两种情况下, Strategy都可以请求到它所需要的数据。但现在Context必须对它的数据定义一个更为精细的接口,这将 Strategy和Context更紧密地耦合在一起。
 2) 【也叫泛型】将Strategy作为模板参数在C++中,可利用模板机制用一个Strategy来配置一个类。然而这种技术仅当下面条件满足时才可以使用
    * 可以在编译时选择 Strategy
    * 它不需在运行时改变。在这种情况下,要被配置的类(如,Context)被定义为以一个Strategy类作为一个参数的模板类
    
    ![](3.png)
    
    使用模板不再需要定义给Strategy定义接口的抽象类。把 Strategy作为一个模板参数也使得可以将一个 Strategy和它的 Context:静态地绑定在一起,从而提高效率。
 3) 使Strategy对象成为可选的。如果即使在不使用额外的Strategy对象的情况下, Context也还有意义的话,那么它还可以被简化。Context在访问某Strategy前先检查它是否存在,如果有,那么就使用它;如果没有,那么 Context执行缺省的行为。这种方法的好处是客户根本不要处理 Strategy对象,除非它们不喜欢缺省的行为。
 
 ## 相关模式
 * Flyweight(4.6): Strategy.对象经常是很好的轻量级对象。
 
 ## 其他知识点
 
 */

import Cocoa

protocol Compositor {
    
}

class CompositorA: Compositor {
    
}

class CompositorB: Compositor {
    
}

class Context {
    let compositor: Compositor
    
    init(compositor: Compositor) {
        self.compositor = compositor
    }
}

let compositorA = CompositorA()
let compositorB = CompositorB()

let context =  Context(compositor: compositorA)
