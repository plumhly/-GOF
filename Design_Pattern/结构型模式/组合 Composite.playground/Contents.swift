/*:
# 组合 Composite -- 对象结构型模式

## 意图
将对象组合成树形结构以表示“部分-整体”的层次结构。Composite使得用户对单个对象和组合对象的使用具有一致性。

## 动机
在图形应用程序当中，用户使用简单的组件创建较大的组件，然后这些较大的组件又可以组成更大的。一个简单的的方式是为Text和Line创建各自的类，另外定义一些类作为容器。但是这样有个问题：
1. 使用这些类的代码必须区别对待Text和Line。但是用户觉得他们都是一样的。区别的使用会增加复杂性。
![](p1.png)

Composite模式的关键是一个抽象类，它既可以表示图元，又可以表示图元的容器。Graphic就是这样的类，它声明一些图形特定的操作，如Draw。Text、Line、Retangle定义了一些图元对象，它们分别实现各自的Draw方法。Picture是一个Graphic对象的集合，它的Draw方法通过调用聚合对象的Draw方法达到目的。由于Picture对象接口和Graphic一样，那么它可以递归的组合其他Picture对象。
![](p2.png)

## 适用性
1. 你想表示对象的部分-整体层次结构
2. 你希望用户忽略组合对象与单个对象的不同，用户将统一的使用组合结构中的所有对象。

## 结构
![](p3.png)

典型的Composite对象的结构如下图：
![](p4.png)

## 参与者
* Component
1. 为组合中的对象声明接口
2. 在适当情况下，实现所有类共有接口的缺省行为
3. 声明一个接口用于访问和管理Component的子组件
4（可选）在递归结构中定义一个接口，用于访问一个父组件，并在适合的情况下实现它

* Leaf
1. 在组合中表示叶子节点的对象
2. 在组合董定义图元对象的行为

* Composite
1. 定义有子部件的那些部件的行为
2. 存储子部件
3. 在Component接口中实现与子部件有关的操作

* Client
通过Component接口操作组合部件的对象

## 协作
用户使用Component类接口与组合结构中的对象进行交互。如果接收者是一个节点，则直接处理请求。如果接收者是Composite，它通常将请求发送给它的子部件，在转发请求之前或者之后坑执行一些辅助操作。

## 效果
1. 定义可包含基本对象和组合对象的类层次结构。他们可以不断的组合。客户端代码中任何使用基本对象的地方都可以使用组合对象。
2. 简化客户代码。客户可以一致的使用单个对象和组合对象。
3. 使得更容易增加新类型的的组件。客户代码不会因为新的Component类的增加而修改代码。
4. 使得你的设计变得更加一般化。容易增加新组件也会有一个问题：很难限制组合中的组件。

## 实现
在实现Composite模式时需要考虑以下问题：
1. 显示的父组件引用。保持子部件到父部件的引用能简化组合结构的遍历和管理。父部件的引用可以简化结构的上移和删除，同时父部件引用也支持 Chain Of Responsibility。通常在Component中定义父部件的引用，Composite和Leaf类可以继承。
2. 共享组件。共享组件是很有用的，比如它可以减少对存贮的要求。但是只有一个父部件时，是很难共享的。一个可行的解决方法是为子部件引用多个父部件，但是这样会导致多义性（Flyweight模式可以解决）

3. 最大化Component接口。Composite模式的目的之一是使得用户不知道正在使用的是Composite还是Leaf。为达到该目的，就需要再Component中多定义一些Composite和Leaf的公共接口。但是这有时候会与类层次结构设计原则相冲突，该原则规定：一个类只能定义那些对它的子类有意义的操作。有许多对Composite有用的操作对于Leaf却没有任何意义。那么Component该怎样为他们提供缺省操作呢？这里可以创造性的把Leaf看成节点为空的Composite。

4. 声明管理子部件的操作。虽然Composite类实现了Add和Remove操作用于管理子部件。但是在Composite模式当中一个重要的问题是：在Composite类层次机构中哪一些类什么这些操作。 这里需要从透明性和安全性方面考虑：
a. 在类层次的根部定义子节点管理接口的方法具有良好的透明性，因为你可以一致的使用所有组件，但这是以安全性为代价的，因为客户可能会做一些无意义的操作：比如在Leaf中添加和删除对象。
b. 在Composite类中定义管理子组件的操作接口具有良好的安全性。因为在Leaf中添加或者删除都会在编译的时候被发现。但这又损失了透明性，因为Leaf和Composite类具有不同的接口。
在这里我们选择透明性!!

5. Component是否应该实现一个Component列表。
6. 子部件排序。必须仔细设计管理接口，Iterator模式有一定帮助
7. 使用高速缓冲存贮改善性能。如果需要频繁的遍历或者查找，Composite类可以缓存对它的子节点进行遍历或者查找的信息。
8. 应该由谁删除Component。通常最好是Composite类
9. 存贮组件最好用哪一种数据结构

## 相关模式
1. 通常部件-父部件连接用于Responsibility Of Chain模式
2. Decorator模式经常与Composite模式一起使用。但Decorator和Composite一起使用时，他们通常有一个公共的父类，因此，Decorator必须具有Add、Remove和GetChild的Component接口
3. Flyweight让你共享组件，但不再能引用他们的父组件
4. Iterator用来遍历Composite
5. Visitor 将本应该分布在Composite和Leaf类中操作和行为局部化

## 其他知识点

*/

protocol Component {
	func add(component: Component)
	func delete(component: Component)
	func doSomething()
}

extension Component {
	func add(component: Component) {}
	func delete(component: Component) {}
	func doSomething() {}
}

class Composite: Component {
	
	var components: [Component] = []
	
	func add(component: Component) {
		components.append(component)
	}
	
	func delete(component: Component) {
		let index = 0
		components.remove(at: index)
	}
	
	func doSomething() {
		
	}
}


class Leaf: Component {
	func doSomething() {
		
	}
}

class Client {
	
	func doSomething(component: Component) {
		
	}
}

let client = Client()

let composite1: Component = Composite()
let composite2: Component = Composite()
let leaf: Component = Leaf()

composite1.add(component: composite2)
composite1.add(component: leaf)

client.doSomething(component: composite1)
client.doSomething(component: leaf)

