
/*:
# 工厂方法 Factory Method -- 对象创建型模式

## 意图
定义一个创建对象的接口，让子类决定实例化哪一个类。Factory Method 使得一个类的实例化延迟到了其子类

## 别名
虚构造器

## 动机
解决只知道不能实例化的抽象类，而不知道具体的子类。这时候提供一个创建对象的接口，由子类实现。

## 适用性
* 当一个类不知道它所必须创建的对象的类的时候
* 当一个类希望由它的子类来指定所创建对象的时候
* 当类将创建对象的职责委托给多个帮助子类中的某一个，并且你希望将哪一个帮助子类是代理者这一信息局部化的时候。

## 结构
![](Factory_method.png)

## 参与者
* Product
定义工厂方法所创建对象的接口

* ConcreteProduct
实现Product接口

* Creator
声明工厂方法，该方法返回一个Product类型的对象。Creator也可以定义一个工厂方法的缺省实现，它返回一个缺省的ConcreteProduct对象。

* ConcreteCreator
重定义工厂方法以返回一个ConcreteProduct

## 协作
Creator依赖于它的子类来定义工厂方法，所以它返回一个适当的ConcreteProduct实例

## 效果
1. 为子类提供挂钩（hook）。
2. 连接平行的类层次。【当一个类将它的一些职责委托给一个独立的类的时候，就产生了平行类层次】


### 缺点:
1. 要创建一个ConcreteProduct就需要创建一个ConcreteCreator

## 实现
1. 主要有两种不同的情况。
* Creator是一个抽象类，不提供工厂方法的实现。这样避免不了不得不实例化不可遇见类的问题。
* Creator是一个具体的类，并提供一个缺省的实现。这样更加灵活。

2. 参数化工厂方法。使得工厂方法可以创建多种产品。
3. 特定语言的变化和问题
4. 使用模板避免创建子类
5 . 命名约定


## 相关模式
1. Abstract Factory经常使用工厂方法来实现。
2. 工厂方法通常在Template Method中被调用

## 其他知识点

*/

import Cocoa

protocol Product {
	
}

protocol Creator {
	func creatProduct() -> Product
}

struct ProductA: Product {
	
}

struct CreatorA: Creator {
	func creatProduct() -> Product {
		return ProductA()
	}
}
