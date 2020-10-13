/*:
# 建造者 Builder

## 意图
将一个复杂的对象的构建和它的表现分离，使得同样的建造过程可以创建不同的表示。

【由Director来设计构建的流程，进而组成产品】

## 动机
一个富文本的转其他格式的阅读器，例如可以将富文本转换成 ASCII文本。但问题是转换的样式是无限的，因此要容易的实现新的转换的增加，同时不改变阅读器。

![](intension.png)

每一个转换器将创建复杂对象的过程隐藏在抽象接口的后面，转换器独立于阅读器，阅读器负责语法分析。

## 适用性
* 当创建复杂对象的算法应该独立于该对象的组成部分以及他们的装配方式时
* 当构造过程必须允许被构造的对象有不同的表示时

## 结构
![](constructure.png)

## 参与者
* Builder
1. 为创建一个Product对象的各个部件指定的抽象接口。

* ConcreteBuilder
1. 实现Builder的接口以构造和装配该产品的各个部分。
2. 定义并明确它所创建的表示
3. 提供一个检索产品的接口

* Director
1. 创建一个使用Builder接口的对象

* Product
1. 表示被构造的复杂对象。ConcreteBuilder创建该产品的内部表示并定义它的装配过程。
2. 包含定义组成部件的类，包含将这些部件装配成最终产品的接口。

## 协作
1. Client创建Director对象，并用它所想要的Builder对象进行配置
2. 一旦产品部件被生成，Director就会通知Builder
3. Builder处理Director的请求，并将部件添加到该成品当中
4. Client从生成器中检索产品

以下是交互图

![](process.png)

## 效果
### 优点：
1. 他可以改变一个产品的内部表示。 Builder对象提供给Director一个构造产品的抽象接口。该接口使得生成器可以隐藏这个产品的表示和内部结构。同时隐藏了该产品是如何装配的。因为产品是通过抽象接口构造的，你在改变该产品的内部表示时所要做的只是定义一个新的生成器。

2. 它将构造代码和表示代码分开。 Builder模式通过封装一个复杂的对象的创建和表示方式提高可产品的模块性。客户不需要知道定义产品内部结构的类的所有信息；这些类是不出现在Builder的接口当中的。每一个ConcreteBuilder包含创建和装配一个特定产品的所有代码。这些代码只需要写一次。然后不同的Director可以复用它以在相同部件集合的基础上构造不同的Product。
【Director可以通过调用Builder不同的接口，从而影响构造的产品】

3. 它可以使你对构造过程的控制更加精细。Builder模式和一下子就生成产品的创建型模式不同。他是在Director的控制下一步一步的构造产品。仅当产品构建完成时，Director才从Builder中取回它。因此Builder接口相比于其他创建型模式更好的反应产品的构造过程，这使你更精细的控制构造过程，从而更精细的控制所得产品的内部结构。

## 实现
需要考虑的问题：
1. 装配和构造接口。Builder中的接口必须够普遍以便为各种类型的ConcreteBuilder构造产品。
a. 一个关键的设计问题在于构造和装配过程的模型，构造的结果只是被添加到了产品中，通常这样的模型就足够了
b. 有时你需要访问前面已经构造的产品部件。（在已经存在的房间之间加门，就需要返回节点）。这种情况下，生成器会将子节点返回给Director，然后Director将他们回传给bui
2. 为什么产品没有抽象类。通常情况下Builder生成的产品区别是很大的。
3. 在Builder中缺省方法为空。使得ConcreteBuilder实现他们感兴趣的内容

## 相关模式
Abstract Factory和Builder相似，因为他们可以创建复杂对象。主要的区别：
1. Builder模式是一步步构建一个复杂对象。而Abstract Factory着重于多个系列产品对象（简单或者复杂）
2. Builder在最后一步返回产品，而对于Abstract Factory是立即返回产品
 
## 其他知识点
1. 之前有个疑惑：为什么返回最终产品不是通过Director的接口获取？原因是产出的Product可能是很大差别的，写在Director里面，不同产品会不断的改接口，比如getResult1, getResult2....，这样设计不好，最好的设计是放在也在变化的ConcreteBuilder里面。
2. 同一个Director，同样的流程可以构建不一样的产品，也就是不同的表现形式
3. 同一样的Builder，也可以用于不同的Director
4. 可以把Builder想象成大学四年的学习

*/
import Foundation

protocol Builder {
	func buildPartA()
	func buildPartB()
	func buildPartC()
}

struct ProductA {
	func doA() {}
	func doB() {}
	func doC() {}
}

struct ConcreateBuilder1: Builder {
	private var product = ProductA()
	
	func buildPartA() {
		product.doA()
	}
	
	func buildPartB() {
		product.doB()
	}
	
	func buildPartC() {
		product.doC()
	}
	
	// public, 这里拿给Client调用
	func result() -> ProductA {
		return product
	}
}


struct ProductB {
	func doA() {}
	func doB() {}
	func doC() {}
}

struct ConcreateBuilder2: Builder {
	private var product = ProductB()
	
	func buildPartA() {
		product.doA()
	}
	
	func buildPartB() {
		product.doB()
	}
	
	func buildPartC() {
		product.doC()
	}
	
	// public, 这里拿给Client调用
	func result() -> ProductB {
		return product
	}
}

struct Dicrector {
	func construct(with builder: Builder) {
		// 这里根据Dicrector来控制流程【同一样的构建过程，不同的表示形式】
		builder.buildPartA()
		builder.buildPartB()
		builder.buildPartC()
		builder.buildPartC()
		builder.buildPartB()
		builder.buildPartA()
	}
}

struct Client {
	func build() {
		
		/*
		同一个Director控制不同的产品
		*/
		let builder1 = ConcreateBuilder1()
		let director = Dicrector()
		director.construct(with: builder1)
		let result = builder1.result()
		
		let builder2 = ConcreateBuilder2()
		director.construct(with: builder2)
		let resul2 = builder2.result()
	}
}
