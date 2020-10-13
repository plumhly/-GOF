/*:
# 抽象工厂

## 意图
提供一个创建一系列相关或者相互依赖对象的接口，而无需指定他们具体的类

## 别名
Kit

## 动机
考虑一个可以呈现多种视感标准的用户界面工具包

## 适用性
* 一个系统要独立于他的产品的创建、组合、表示时
* 一个系统需要多个产品系列中的一个来进行配置时
* 当想要强调一系列相关的产品对象的设计以便进行联合使用时
* 当你提供一个产品类库，而只想显示他们的接口而不是实现时

## 结构
![](abstract_factory.png)

## 参与者
* AbstractFactory
  声明一个创建抽象产品对象的操作接口

* ConcreteFactory
	实现创建具体产品对象的操作

* AbstractProduct
	为一类产品对象声明一个接口

* ConcreteProduct
	定义一个将被相应的具体工厂创建的产品对象
	实现AbstractProduct接口

* Client
	仅使用由AbstractFactory和AbstractProduct类声明的接口

## 协作
* 通常在运行时刻创建一个ConcreteFactory类的实例。这一具体的工厂创建具有特定实现的产品对象。为创建不同的产品对象，Client使用不同的具体工厂
* AbstractFactory将产品的创建延迟到他的ConcreteFactory子类

## 效果
### 优点：
1. 它分离了具体的类。
2. 它使得易于交换产品系列。
3. 它有利于产品的一致性

### 缺点:
1. 难以支持新种类的产品。因为支持新产品，就要创建新的接口，那么所有ConcreteFactory都要被修改

## 实现
1. 将工厂作为单件。因为一个应用一般每个产品系列只需要一个ConcreteFactory的实例。因此工厂最好实现一个Singleton
2. 创建产品。AbstractFactory仅声明一个创建产品的接口，真正创建产品的是由ConcreteProduct子类实现的。最通常的一个方法是为每一个产品定义一个工厂方法。
3. 定义可扩展的工厂。给创建对象的操作增加一个参数。【?】

## 相关模式
1. Abstract Factory 类通常用工厂方法（Factory Method）实现，但是也可以用Prototype实现
2. 一个具体的工厂通常是一个单件（Singleton）

## 其他知识点
1. 注意MazeFactory仅是工厂方法的一个集合。这是最通常的实现Abstract Factory模式的样式。同事注意MazeFactory也不是一个抽象类，它既作为Abstract Factory，也是Concrete Factory。这是Abstract Factory模式的简单应用的另一个通常的实现。
![](MazeFactory.png)
*/


import Cocoa

// MARK: - AbstractFactory
protocol AbstractFactory {
	func createProductA() -> AbstractProductA
	func createProductB() -> AbstractProductB
}

protocol AbstractProductA {
	func function1()
	func function2()
}

protocol AbstractProductB {
	func function1()
	func function2()
}


// MARK: - ConcreteFactory1
class ConcreteProductA_1: AbstractProductA {
	func function1() {}
	func function2() {}
}

class ConcreteProductB_1: AbstractProductB {
	func function1() {}
	func function2() {}
}

class ConcreteFactory1: AbstractFactory {
	func createProductA() -> AbstractProductA {
		return ConcreteProductA_1()
	}
	
	func createProductB() -> AbstractProductB {
		return ConcreteProductB_1()
	}
}


// MARK: - ConcreteFactory2
class ConcreteProductA_2: AbstractProductA {
	func function1() {}
	func function2() {}
}

class ConcreteProductB_2: AbstractProductB {
	func function1() {}
	func function2() {}
}

class ConcreteFactory2: AbstractFactory {
	func createProductA() -> AbstractProductA {
		return ConcreteProductA_2()
	}
	
	func createProductB() -> AbstractProductB {
		return ConcreteProductB_2()
	}
}


// MARK: - Client
class Client {
	func create(with factory: AbstractFactory) {
 		let productA = factory.createProductA()
		let productB = factory.createProductB()
	}
}
