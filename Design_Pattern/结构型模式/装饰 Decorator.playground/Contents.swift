/*:
# 装饰 Decorator -- 对象结构型模式

## 意图
动态地给一个**对象**添加一些额外的职责，就增加功能来说，Decorator模式相比生成子类更为灵活。

## 别名
包装器 Wrapper

## 动机
有时候，我们希望给某个对象而不是整个类添加一些功能。例如，一个图形用户界面库允许你对任意一个用户界面组件添加一些特性，如边框、滑动等。这里有两种方式：
1. 采用继承。继承该用户界面，添加某些边框等功能，但是这样不够灵活，因为边框等功能的选择是静态的，用户不能控制对组件加边框的方式和时机。而且遇到功能的组合也很难解决，因为这是一个排列问题。
2. 采用组合。将组件嵌入另一个对象中，由这个对象添加边框，我们称为装饰。这个装饰与所装饰的组件接口一致，因此它对使用该组件的客户透明。它将客户请求发给该组件，并且可能在转发前后执行一些额外操作（如画一个边框）。

采用装饰模式的解决方案的关系图如下：
![](1.png)

结构图如下：
![](2.png)

这个模式在使用VisualComponent的地方都可以用Decorator。客户通常不会感觉装饰过得组件与未装饰组件之间的差异，也不会对装饰产生依赖。

## 适用性
以下情况使用Decorator模式：
* 在不影响其他对象的情况下，以动态，透明的方式给单个对象添加职责
* 处理那些可以取消的职责
* 当不能采用生成子类的方法进行扩充时。一种情况是，可能有大量独立的扩展，为支持每种组合将产生大量的子类，使得子类数目呈爆炸性增长。另一种情况可能是因为类定义被隐藏，或者不能生成子类

## 结构
![](3.png)

## 参与者
* Component
-- 定义一个对象接口，可以给这些对象动态的添加职责。

* ConcreteComponent
-- 定义一个对象，可以给这个对象添加一些职责

* Decorator
-- 是Component的子类，维护一个指向Component的指针

* ConcreteDecorator
-- 向Component添加职责

## 协作
Decorator将请求转发给它的Component对象，并可能在转发请求前后执行一些附加的动作。

## 效果
### 优点：
1. 比静态继承更加灵活。与对象的静态继承相比，Decorator模式提供了更加灵活的向对象添加职责的方式。可以用添加和分离的方法，用装饰在运行时添加或者删除职责。相比之下，继承机制要求为每一个添加的职责创建一个子类。这会产生很多的新类，并且会增加系统的复杂度。此外，为一个特定的Component提供多个不同的Decorator类，这就使得你可以对一些职责进行混合和匹配。这是类继承很难实现的。

2. 避免在层次结构高层的类有太多的特征。Decorator模式提供一种“即用即付”的方式类添加职责。它并不试图在一个复杂可定制的类中支持所有可预见的特征，相反，你可以定义一个简单的类，并且用Decorator类给它逐渐添加功能。可以从简单的部件组合成复杂的功能。并且每个Decorator可以独立的变化

### 缺点:
1. Deocrator与它的Component不一样，Decorator是一个透明的包装。如果我们从对象标识的观点出发，一个被装饰了的组件与这个组件是有差别的，因此，使用装饰时，不应该依赖于对象标识。
2. 有许多小对象。采用Decorator模式进行系统设计往往会产生许多看上去一样的小对象，虽然容易定制，但是很难学习这些系统，排错也很困难。

## 实现
使用Decorator模式时应该注意以下几点：
1. 接口的一致性。Decorator的接口必须与Component的接口一致，因此，所有的ConcreteDecorator类必须有一个功能类（至少C++中如此）。

2. 省略抽象的Decorator类。当你仅需要添加一个职责时，没有必要定义一个抽象的Decorator。这时，你可以把Decorator向Component转发请求的职责合并到ConcreteDecorator当中。

3. 保持Component的简单性。为了保证接口一致性，组件和Decorator必须有一个公共的Component父类。Component的主要职责是定义接口。

4. 改变对象外壳与改变对象内核。我们可以把Decorator看成对象的外壳，它可以改变对象的行为。另外一种是改变对象内核（如Strategy模式）。当Component原本很庞大时，使用Decorator模式代价太高，Strategy模式相对更好一点。在Strategy模式中，Component把它的一些行为转发到一个独立的策略对象，我们可以改变Strategy对象，从而改变组件的功能。由于Decorator仅从外部改变组件，因此，组件对它的装饰无需了解，也就是说这些装饰是透明的。如下图所示：
![](4.png)

在Strategy模式当中，Component本身知道可能进行哪些扩展，因此必须引用并维护相应的策略。如下图所示：
![](5.png)

基于Strategy的方法可能需要修改组件，以适应新的扩充。另一方法，Strategy模式可以有自己特定的接口，而Decorator的接口必须与Component一致。例如，一个绘制边框的Strategy仅需要定义生成边框的接口（DrawBorder, GetWidth），这意味着即使Component很大时，Strategy也可以很小。

## 相关模式
1. Adapter模式：Decorator模式不同于Adapter模式，因为Decorator仅改变对象的职责而非接口，而Adapter将给对象一个全新的接口。
2. Component模式：可以将Decorator视为一个退化的、仅有一个组件的Composite。然而，Decorator仅给对象添加一些额外的职责--它的目的不在于对象聚集。
3. Strategy模式：Decorator改变对象的外表，而Strategy模式改变对象的内核，这是改变对象的两种途径。


## 其他知识点
1. 理解给对象添加功能而不是类。如果给类添加了一些方法，那么这个类生成的对象都具有那个功能，这是静态的。但是可以通过组合对象的方式扩展新的功能，从这个角度看来，这就是给对象添加了功能。
*/


protocol Component {
	func drawContent()
}

class ConcreteComponent: Component {
	func drawContent() {
		
	}
}

class Decorator: Component {
	private let component: Component
	init(component: Component) {
		self.component = component
	}
	func drawContent() {
		component.drawContent()
	}
}

class BorderDecorator: Decorator {
	override init(component: Component) {
		super.init(component: component)
	}
	
	override func drawContent() {
		// draw border action
		super.drawContent()
	}
}


class ScrollDecorator: Decorator {
	override init(component: Component) {
		super.init(component: component)
	}
	
	override func drawContent() {
		// scroll action
		super.drawContent()
	}
}

class Client {
	func doSomething(with component: Component) {
		
	}
}

let client = Client()
let originalComponent = ConcreteComponent()
let component = ScrollDecorator(component: BorderDecorator(component: originalComponent))
client.doSomething(with: component)
