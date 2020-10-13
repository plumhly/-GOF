
/*:
# 桥接 Bridge   --- 对象结构型模式

## 意图
将抽象部分和它的实现部分分离

## 别名
Handle/Body

## 动机
继承机制将抽象部分与它的实现部分固定在一起，使得难以对抽象部分和实现部分独立的进行修改、扩充、重用。
> 举例：
假如一个用户界面工具箱，其中有个抽象的Window类，为了考虑到平台型，可能采用继承机制，创建一个 X window system的`XWindow`和 PM 的 `PMWndow`。采用继承机制有两个不足之处：
1. 当有一个新的需求，需要创建一个图标的Window时，那么就创建一个继承自Window的IconWindow。由于考虑到平台原因，就会创建两个继承自IconWindow的子类，IconXWindow 和 IconPMWindow。但是如果有其他需求或者适配其他平台，那么类的数量是很多的。
![](p2.png)

2. 继承机制使Client代码与平台有关。每当一个用户创建Window时，必须要实例化一个具体的类，这个类有特有的实现部分。例如，创建XWindow对象会将Window抽象与XWindow的实现部分绑定起来，使得Client依赖于XWindow的实现部分，这使得Client很难移植到其他平台。

Bridge模式提供了解决方法：
1. 将Window抽象和它的实现部分分别放在独立的类层次结构中。其中一个类层次结构针对Window接口（WIndow， IconWIndow..）。另一个类层次针对平台相关窗口的实现部分也就是WindowImp。

对WIndow子类的所有操作都是用WindowImp接口中的抽象实现的。这就将窗口的抽象和平台的实现分离开了。因此WIndow和WindowImp之间的关系称为--桥接
![](p1.png)

## 适用性
* 你不希望在抽象和它的实现部分之间有一个固定的绑定关系。
* 类的抽象和他的实现应该可以通过的生成子类的方式加以扩充。这时使用Bridge模式是你可以对不同的抽象接口和实现部分进行组合，并分别对它们进行扩充。
* 对一个抽象的实现部分的修改应对客户不产生影响，即客户的代码不必重新编译。
* （C++）你想对客户隐藏抽象的实现部分。
* 类似图1所示的结构
* 你想在多个对象间共享实现，但是同时要求客户并不知道这一点。

## 结构
![](structure.png)

## 参与者
* Abstraction
a. 定义抽象类的接口
b. 维护一个指向Implementor类型对象的指针。

* RefinedAbstraction
扩充由Abstraction定义的接口

* Implementor
定义实现类的接口，该接口不一定与Abstraction的接口完全一致，事实上这两个接口可以完全不一样。一般来讲Implementor定义一些基本操作，Abstraction则定义一些基于这些基本操作的高级操作。

* ConcreteImplementor
实现Implementor的接口并定义它的具体实现。

## 协作
Abstraction将Client的请求转发给Implementor

## 效果
### 优点：
1. 分离接口及其实现部分。动态配置、降低对实现部分的依赖性、有助于分层。
2. 提高可扩充性
3. 实现部分对客户透明。隐藏实现细节。

## 实现
在使用Bridge模式的时候需要注意一下问题：
1. 仅有一个Implementor。仅有一个实现的时候，没有必要创建一个抽象的Implementor类。这是Bridge模式退化的结果。
2. 创建正确的Implementor类。当存在多个Implementor类（子类）怎样创建正确的Implementor类呢？
a. 构造器传参
b. 创建缺省实现（如collection的大小判断用list还是hash）
c. 用抽象工厂，抽象工厂知道如何创建正确的Implementor类的细节，而且也让Abstraction和Implementor解耦
3. 共享Implementor对象（C++）
4. 采用多次继承机制（C++）

## 相关模式
1. Abstract Factory模式可以用来创建和配置一个特定的Bridge模式（创建Implementor）
2. Adapter模式用来帮助无关类的协同工作，它通常在系统设计完成之后才会使用。
然而，Bridge模式则是在系统开始的时候就使用。

## 其他知识点

*/

import Foundation


protocol Implementor {
	func implemention1()
	func implemention2()
}

protocol Absctraction {
	init(i: Implementor)
	
	func absctraction1()
	func absctraction2()
}

class RefinedAbsctraction: Absctraction {
	var implement: Implementor
	required init(i: Implementor) {
		implement = i
	}
	
	func absctraction1() {
		implement.implemention1()
	}
	
	func absctraction2() {
		implement.implemention2()
	}
	
	func other() {
		
	}
}

class ConcreatImplemention: Implementor {
	func implemention1() {
		
	}
	
	func implemention2() {
		
	}
}

class Client {
	func doThing() {
		let ci1 = ConcreatImplemention()
		let ab1 = RefinedAbsctraction(i: ci1)
		ab1.absctraction1()
		ab1.absctraction2()
	}
}

// 第二种实现
protocol AbsctractionOther {
	func absctraction1()
	func absctraction2()
}

class AbsctractFactory {
	static func createImp() -> Implementor {
		// 这是可以读取配置文件
		if true {
			return ConcreatImplemention()
		}
	}
}

class RefinedAbsctractionOther: AbsctractionOther {
	let implement: Implementor = AbsctractFactory.createImp()
	
	func absctraction1() {
		implement.implemention1()
	}
	
	func absctraction2() {
		implement.implemention2()
	}
	
	func other() {
		
	}
}

extension Client {
	func doOther() {
		let ab1 = RefinedAbsctractionOther()
		ab1.absctraction1()
		ab1.absctraction2()
	}
}
