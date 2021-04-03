/*:
 # 状态 - State  -- 对象行为型模式
 
 ## 意图
 允许一个对象在其内部状态改变时改变它的行为。对象看起来似乎修改了它的类。
 
 ## 别名
 状态对象（Object for State）
 
 ## 动机
 考虑一个表示网络连接的类TCPConnection。一个TCPConnection对象的状态处于若干不同状态之一:连接已建立 Established)正在监听(Listening)、连接已关闭(Closed)。
 当一个Tcpconnection对象收到其他对象的请求时,它根据自身的当前状态作出不同的反应。例如,一个Open请求的结果依赖于该连接是处于连接已关闭状态还是连接已建立状态。
 Statel模式描述了 Tcpconnection如何在每一种状态下表现出不同的行为。
 
 这一模式的关键思想是引入了一个称为 Tcpstate的抽象类来表示网络的连接状态。Tcpstate类为各表示不同的操作状态的子类声明了一个公共接口。 Tcpstatel的子类实现与特定状态相关的行为。
 例如, Tcpestablished和 Tcpcloseda类分别实现了特定于 Tcpconnectione的连接已建立状态和连接已关闭状态的行为。
 
 ![](1.png)
 
 TCPConnection类维护一个表示TCP连接当前状态的状态对象(一个TCPState-子类的实例)。
 TCPConnection类将所有与状态相关的请求委托给这个状态对象。TCPConnection使用它的TCPState-子类实例来执行特定于连接状态的操作。
 旦连接状态改变, TCPConnection对象就会改变它所使用的状态对象。例如当连接从已建立状态转为已关闭状态时, TCPConnection会用一个TCPClosede的实例来代替原来的TCPEstablishede的实例。
 
 ## 适用性
 在下面的两种情况下均可使用State模式:
 * 一个对象的行为取决于它的状态,并且它必须在运行时刻根据状态改变它的行为。
 * 个操作中含有庞大的多分支的条件语句,且这些分支依赖于该对象的状态。这个状态通常用一个或多个枚举常量表示。通常,有多个操作包含这一相同的条件结构。 State 模式将每一个条件分支放入一个独立的类中。这使得你可以根据对象自身的情况将对象的状态作为一个对象,这一对象可以不依赖于其他对象而独立变化。
 
 ## 结构
 
 ![](2.png)
 
 ## 参与者
 -- Contex(环境,如 Tcpconnection)
 * 定义客户感兴越的接口。
 * 维护一个 Concretestate子类的实例,这个实例定义当前状态。
 
 -- State(状态,如TCPState)
 * 定义一个接口以封装与Context的一个特定状态相关的行为。
 
 -- Concrete State subclasses(具体状态子类,如 TCPEstablished, TCPListen, TCPClosed)
 * 每一子类实现一个与Context的一个状态相关的行为。
 
 ## 协作
 * Context将与状态相关的请求委托给当前的ConcreteState对象处理。
 * Context可将自身作为一个参数传递给处理该请求的状态对象。这使得状态对象在必要时可访问 Context。
 * Context是客户使用的主要接口。客户可用状态对象来配置一个Context,一旦一个Context配置完毕,它的客户不再需要直接与状态对象打交道。
 * Contexte或Concretestate-子类都可决定哪个状态是另外哪一个的后继者,以及是在何种条件下进行状态转换。
 
 ## 效果
 State模式有下面一些效果:
 1) 它将与特定状态相关的行为局部化,并且将不同状态的行为分割开来。 State模式将所有与一个特定的状态相关的行为都放入一个对象中。因为所有与状态相关的代码都存在于某一个State子类中,所以通过定义新的子类可以很容易的增加新的状态和转换。
 
    另一个方法是使用数据值定义内部状态并且让Context操作来显式地检査这些数据。但这样将会使整个 contextl的实现中遍布看起来很相似的条件语句或case语句。增加一个新的状态可能需要改变若干个操作,这就使得维护变得复杂了。
 
    State模式避免了这个问题,但可能会引入另一个问题,因为该模式将不同状态的行为分布在多个 State子类中。这就增加了子类的数目,相对于单个类的实现来说不够紧凑。但是如果有许多状态时这样的分布实际上更好一些,否则需要使用巨大的条件语句
 
 2) 它使得状态转换显式化。当一个对象仅以内部数据值来定义当前状态时,其状态仅表现为对一些变量的赋值,这不够明确。为不同的状态引入独立的对象使得转换变得更加明确。
 而且,State对象可保证Context不会发生内部状态不一致的情况,因为从Context的角度看,状态转换是原子的一一只需重新绑定一个变量(即Context的State对象变量),而无需为多个变量赋值。
 
 3) State对象可被共享。如果State对象没有实例变量一即它们表示的状态完全以它们的类型来编码——那么各Context对象可以共享ー个State对象。当状态以这种方式被共享时,它们必然是没有内部状态,只有行为的轻量级对象(参见 Flyweight(4.6))。
 
 ## 实现
 实现 State模式有多方面的考虑：
 1) 谁定义状态转换State模式不指定哪一个参与者定义状态转换准则。如果该准则是固定的,那么它们可在Context中完全实现。然而若让State-子类自身指定它们的后继状态以及何时进行转换,通常更灵活更合适。这需要Contextl增加一个接口,让 State)对象显式地设定Context的当前状态。
 用这种方法分散转换逻辑可以很容易地定义新的 State子类来修改和扩展该逻辑。这样做的一个缺点是,一个 State子类至少拥有一个其他子类的信息,这就再各子类之间产生了实现依赖。
 
 2) 基于表的另一种方法。在C++ Programming Style中, Cargill描述了另一种将结构加载在状态驱动的代码上的方法:他使用表将输入映射到状态转换。对每一个状态,一张表将每一个可能的输入映射到一个后继状态。实际上,这种方法将条件代码(和 State/模式下的虚函数)映射为一个查找表。
 表驱动的状态机和 State模式的主要区别可以被总结如下: State模式对与状态相关的行为进行建模,而表驱动的方法着重于定义状态转换。
 
 3)创建和销毁。 State对象一个常见的值得考虑的实现上的权衡是,究竟是：
    (1)仅当需要 State 对象时才创建它们并随后销毁它们,还是
    (2)提前创建它们并且始终不销毁它们。
 当将要进入的状态在运行时是不可知的,并且上下文不经常改变状态时,第一种选择较为可取。这种方法避免创建不会被用到的对象,如果 Statey对象存储大量的信息时这一点很重要。
 当状态改变很频繁时,第二种方法较好。在这种情况下最好避免销毁状态,因为可能很快再次需要用到它们。此时可以预先一次付清创建各个状态对象的开销,并且在运行过程中根本不存在销毁状态对象的开销。但是这种方法可能不太方便,因为 Contextl必须保存对所有可能会进人的那些状态的引用。
 
 4) 使用动态继承改变一个响应特定请求的行为可以用在运行时刻改变这个对象的类的办法实现,但这在大多数面向对象程序设计语言中都是不可能的。 Self[lus87]和其他一些基于委托的语言却是例外,它们提供这种机制,从而直接支持 State模式。Self中的对象可将操作委托给其他对象以达到某种形式的动态继承。在运行时刻改变委托的目标有效地改变了继承的结构。这一机制允许对象改变它们的行为,也就是改变它们的类。
 
 ## 相关模式
 * Flyweight模式(4.6)解释了何时以及怎样共享状态对象。
 * 状态对象通常是 Singleton(3.5)。
 
 
 
 ## 其他知识点
 
 */

import Cocoa


protocol TCPState {
    func listen(connection: TCPConnection)
    func open(connection: TCPConnection)
    func close(connection: TCPConnection)
    
}

extension TCPState {
    func open(connection: TCPConnection) {}
    func close(connection: TCPConnection) {}
    func listen(connection: TCPConnection) {}
}

struct TCPListen: TCPState {
    func listen(connection: TCPConnection) {
        connection.change(state: TCPOpen())
    }
}

struct TCPOpen: TCPState {
    func open(connection: TCPConnection) {
        connection.change(state: TCPClose())
    }
}

struct TCPClose: TCPState {
    func close(connection: TCPConnection) {
        
    }
}

class TCPConnection {
    var state: TCPState?
    
    func change(state: TCPState) {
        self.state = state
    }
    
    func listen() {
        state?.listen(connection: self)
    }
    
    func open() {
        state?.open(connection: self)
    }
}
