import Cocoa

/*:
# 享元模式 -- Flyweight

## 意图
运用共享技术有效的支持大量细粒度的对象。

## 动机
有些应用程序得益于在整个设计过程当中采用对象技术，但是简化的实现代价太大（会耗用大量内存）。
 例如：文字编辑器。
 如果按照下图设计
 ![](1.png)
 那么，及时中等大小的文档可能也有成百上千的文字对象，这会消耗大量内存。Flyweight模式提供了解决方法。
 flyweight是一个共享对象，他可以同时在多个场景（Context）中使用（外部状态）。其中关键的概念是内部状态和外部状态之
 的区别。
 
 内部状态：存储在flyweight中，它包含了独立于Context的信息。这些信息可以使得flyweight被共享
 外部状态：取决于Context，随Context变化而变化。
 
 用户对象负责必要时将外部状态传递给Flyweight。
 
 还是以编辑器来说明。原来的设计
 ![](2.png)
 
 使用Flyweight模式后的设计。
 ![](3.png)
 
 类关系图：
 ![](4.png)
 

## 适用性
* 一个应用使用了大量对象
* 完全由于使用了大量对象，产生了很大的存储开销
* 对象的大多数状态都可以变成外部状态
* 如果删除对象的外部状态，那么可以用相对少的共享对象取掉很多组对象
* 应用不依赖于对象标识，由于Flyweight对象可以被共享，对于概念上明显有别的对象，标识测试将返回真值
 
## 结构
![](5.png)

## 参与者
 * Flyweight（Glyph）
  -- 描述一个接口，通过这个接口可以接受并作用于外部状态
 
 * ConcreteFlyweight （Character）
 -- 实现Flyweight接口，并为内部状态（如果有的话）增加存储空间。ConcreteFlyweight对象必须是可共享的，他所存储的状态必须是内部的；它必须独立于ConcreteFlyweight对象的场景
 
 * UnsharedConcreteFlyweight （Row Column）
 -- 并非所有的Flyweight子类都需要被共享。Flyweight接口使共享成为可能，但它不强制共享。在Flyweight对象结构的某些层次，UnsharedConcreteFlyweight对象通常将ConcreteFlyweight对象作为子节点（Row和Column就是这样）
 
 * FlyweightFactory
 -- 创建并管理flyweight对象
 -- 确保合理的共享Flyweight，当用户请求一个Flyweight时，FlyweightFactory对象提供一个已创建的实例或者创建一个。
 
 * Client
 -- 维持一个对Flyweight的引用
 -- 计算或者存储一个（多个）Flyweight的外部状态。

## 协作
 * Flyweight执行所需的状态必定是内部或外部的。内部状态存储于ConcreteFlyweight对象中，外部状态则由client存储或者计算。当对象调用Flyweight对象的操作时，将外部状态传递给它
 * 用户不应该直接对ConcreteFlyweight初始化，而由FlyweightFactory获取


## 效果
### 优点：

### 缺点:

## 实现

## 相关模式


## 其他知识点

*/

