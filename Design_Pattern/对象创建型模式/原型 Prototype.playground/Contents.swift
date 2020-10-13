/*:
# 原型 Prototype -- 对象创建型模式

## 意图
用原型实例指定创建对象的类型，并且通过拷贝这些原型创建后的新对象

## 动机
在通用的编辑器框架上添加一些表示音符、休止符、和五线谱的新对象（这些对象还能移动）来开发乐谱编辑器。构造抽象类：
1. 音符和五线谱 -- Graphic
2. 工具  -- Tool
3. 创建音符、休止符、和五线谱等图形对象实例，并加入文档 -- GraphicTool

但是这给框架的设计者带来一个问题：GraphicTool属于框架， 而音符和五线谱却属于应用。GraphicTool不知道如何创建我们的音乐类实例，并添加到乐谱当中。1个方法是为每一个音乐对象创建GraphicTool的子类，但这样会有大量子类。解决办法是让GraphicTool通过拷贝或者克隆一个Graphic子类的实例来穿件新的Graphic

## 适用性
* 当一个系统应该独立于它的产品创建、构成、表示时
* 当要实例化的类是在运行时指定，例如动态加载
* 为了避免创建一个与产品层次平行的工厂类层次
* 当一个类的实例只能有几个不同状态组合中的一种时。建立相应数目的原型并克隆他们可能比每次用合适的状态手工实例化该类更方便。

## 结构
![](Prototype.png)

## 参与者
* Prototype
声明一个克隆自身的接口

* ConcretePrototype
实现一个克隆自身的操作

* Client
让一个原型克隆自身，从而创建新的对象。

## 协作
Client 请求 原型克隆自身

## 效果
1. 和Factory Method 、Builder一样，对客户隐藏了具体类。无需改变就可以使用与特定应用相关的类

### 优点：
1. 运行时刻增加和删除产品。 Prototye允许只通过注册原型实例就可以将一个新的具体的产品类并入系统，它比其他创建型模式更灵活，因为客户可以在运行时刻建立和删除原型。【如果是通过类创建，那么系统就必须知道具体类】

2. 改变值以指定新对象。通过原型定义新类别的对象。

3. 改变结构以指定新对象。

4. 减少子类的构造。Factory Method 经常产生一个与产品类层次平行的Creator类层次。Prototype模式使得你克隆一个原型而不是请求一个工厂方法去生产一个新的对象。因此你根本不需要一个Creator类层次。

5. 用类动态配置应用。

### 缺点:
1. Prototype的主要缺陷是每一个Prototype的子类都必须实现Clone操作，这可能很困难。（内部包括一些不支持拷贝或者有循环引用的对象）

## 实现
1. 使用一个原型管理器
2. 实现克隆操作
3. 初始化克隆对象。

## 相关模式


## 其他知识点

*/


import Cocoa

var str = "Hello, playground"

protocol Prototype {
	func clone() -> Prototype
}

// 值类型自带克隆
class ConcreatePrototype1: Prototype {
	func clone() -> Prototype {
		return ConcreatePrototype1()
	}
	
	var identifier: String = "1"
}


// 值类型自带克隆
class ConcreatePrototype2: Prototype {
	var identifier: String = "2"
	
	func clone() -> Prototype {
		return ConcreatePrototype2()
	}
}


class Client {
	var prototype: Prototype
	init(prototype: Prototype) {
		self.prototype = prototype
	}
	
	func doSomething() {
		let anotherPrototype = prototype.clone()
		// save anotherPrototype
	}
}

let prototype = ConcreatePrototype1()
let client = Client(prototype: prototype)
client.doSomething()



