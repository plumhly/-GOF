/*:
# 单例 Singleton -- 对象创建型内模式

## 意图
保证一个类只有一个实例，并提供一个访问它的全局访问点。

## 动机
很多时候，只能有一个实例，比如公司的会计系统。保证一个类只有一个实例变量，如果采用全局变量的方式，却不能阻止类初始化其他实例，唯一的方式是把实例对象交由该类自己管理，并且提供一个访问该实例的方法，这就是Singleton。

## 适用性
1. 当一个类只能有一个实例而且客户可以从一个众所周知的访问点访问他时。
2. 当这个唯一实例应该是可以通过子类化可扩展的，并且客户应该不用修改代码就能使用一个扩展的实例时。

## 结构
![](singleton.png)

## 参与者
* Singleton
1. 定义Instance操作，允许客户访问唯一实例
2. 可能负责创建它的唯一实例

## 协作
客户只能通过Singleton的Instance操作防疫一个Singleton实例


## 效果
### 优点：
1. 对唯一实例的受控访问， 可以严格控制客户怎样以及何时访问它
2. 缩小名空间 Singlton是对全局变量的一种改进，避免全局变量污染名空间
3. 允许对操作和表示的精化。Singleton可以有子类，你可以在运行时刻配置。
4. 允许可变数目的实例
5. 比类操作更灵活

## 实现
使用Singleton需要考虑的问题：
1. 保证一个唯一的实例；【线程安全】
2. 创建Singleton子类。可以用有个**注册表**或者用**环境变量**控制


## 相关模式


*/

import Foundation

class Singleton {
	static let instance = Singleton()
	
	init() {
		
	}
}

// 有子类

let env = 1

class MySingleton {
	static let instance: MySingleton = {
		if env == 1 {
			return MySingleton1()
		}
		return MySingleton2()
	}()
	
	fileprivate init() {
	
	}
}

class MySingleton1 : MySingleton {
	
}

class MySingleton2 : MySingleton {
	
}
