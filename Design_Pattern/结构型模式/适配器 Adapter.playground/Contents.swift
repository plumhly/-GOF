
/*:
# 适配器 Adapter

## 意图
将一个类的接口转换成客户希望的接口，Adapter模式使得原本接口不兼容的而不能一起工作的那些类，可以一起工作。

## 别名
包装器 Wrapper

## 动机
有时，为了复用而设计的工具箱类不能够复用的原因仅仅因为他的接口与专业应用领域所需的接口不匹配。

## 适用性
1. 你想使用一个已经存在的类，而它的接口不符合你的需求。
2. 你想创建一个可以复用的类，该类可以与其他不相关的类或者不可预见的类（即那些接口可能不一定兼容的列）协同工作。
3. （仅使用与对象Adapter）你想使用一个已经存在的子类，但是不可能对一个都进行子类化以匹配它们的接口。对象适配器可以适配它父类接口。

## 结构
1. 类适配器采用多继承对一个接口与另一个接口进行匹配
![](adapter_class.png)

2. 对象适配器依赖于对象组合
![](adapter_object.png)

## 参与者

Target
* 定义Client使用的与特定领域相关的接口。

Client
* 与符合Target接口的对象协同

Adaptee
* 定义一个已经存在的接口，这个接口需要适配

Adapter
* 对Adaptee接口和Target接口进行适配

## 协作
Client在Adapter上调用一些操作，接着Adapter调用Adaptee的操作来实现这个请求。

## 效果
类适配器和对象适配器的权衡
### 类适配器
* 用一个具体的Adapter类对Target和Adaptee进行适配。结果是当我们想要适配一个类以及其子类时，类Adapter将不能胜任。
* 使得Adapter可以重定义Adaptee的部分行为，因为Adapter是Adaptee得一个子类
* 仅仅引入一个对象，而不需要额外的指针以间接得到Adaptee。

### 对象适配器
* 允许一个Adapter与多个Adaptee （即Adaptee本身已经它的子类）同时工作，Adapter可以一次给所有的Adaptee添加功能。
* 使得重定义Adaptee比较困难。这就需要生成Adaptee的子类，然后Adapter引用这个子类而不是Adaptee本身。

使用Adapter还需要考虑其他因素
1. Adapter的匹配程度。对Adaptee和Target的适配工作量是不同的。
2. 可出入的Adapter
3. 使用双向适配器提供透明操作。双向适配器提供了透明性，在两个不同客户需要的不同地方查看同一个对象时，双向适配器尤为有用
![](adapter_double.png)
有些地方需要QOCA -> Unidraw,有的地方需要  Unidraw ->  QOCA


## 实现
1. 使用C++实现适配器类。在使用C++实现适配器类时，Adapter类应该采用公共方式继承Target类，采用私有方式继承Adaptee类。
2. 可插入适配器，要为Adaptee找到“窄”接口，即可用于适配最小操作集。其实现方式
* 使用抽象操作。在TreeDisplay类中定义窄Adaptee接口相应的抽象操作。让子类来实现这些抽象操作并匹配具体的树结构的对象。
![](plugable_abstract.png)
* 使用代理。将访问树结构的请求转发到代理对象，这样Client就可以对适配加以控制
![](plugable_delegate.png)
3. 参数化Adapter

## 相关模式
1 . 模式Bridge的结构和对象适配器类似。但是Bridge模式的出发点不同：Bridge目的是将接口部分（抽象部分）和实现部分分离，从而对他们可以较为容易也相对独立的加以改变。而Adapter则意味着改变一个已有对象的接口。
2. Decretor模式增强了其他对象的功能而同时又不改变它的接口。因此Decorator应用程序的透明性比Adapter要好。结果是Decorator支持递归组合，而纯粹使用Adapter是不可能实现这一点的。
3. Proxy模式在不改变他的接口的条件下，为另一个对象定义了一个代理。  


## 其他知识点

*/

protocol Target {
	func doSomething()
}

class Adaptee {
	func doThing() {
		
	}
}

// MARK: - 类适配器
class ClassApdater: Adaptee, Target {
	func doSomething() {
		doThing()
	}
}

// MARK: - 对象适配器
class ObjectAdapter {
	let adaptee = Adaptee()
}

extension ObjectAdapter: Target {
	func doSomething() {
		adaptee.doThing()
	}
}
