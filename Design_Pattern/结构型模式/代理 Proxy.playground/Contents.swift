
/*:
 # 代理 - Proxy
 
 ## 意图
 为其他对象提供一种代理以控制对这个对象的访问。
 
 ## 动机
 对一个对象进行访问控制的一个原因是为了只有我们确实需要这个对象的时候才对它进行创建和初始化。比如，有些图形对象（如大型图片）的创建开销就很大。但是打开文档必须很迅速，因此在打开文档时应该避免一次性创建开销很大的对象。（比如邮件附件的占位图）
 采用代理模式可以解决这样的问题。采用图像Proxy代替真正的图像。Proxy可以代替一个图像对象，并且在需要时负责实例化这个图像对象。
 ![](3.png)
 
 ## 适用性
 在需要用比较通用和复杂的对象指针代替简单的指针的时候，使用Proxy模式。下面是使用Proxy模式的常见场景：
 1. 远程代理（Remote Proxy）：为一个对象在不同的地址空间提供局部代表
 2. 虚代理（Virtual Proxy）：根据需要创建开销很大的对象。（imageProxy）
 3. 保护代理（Protection Proxy）：控制对原始对象的访问。保护代理适用于对象应该有不同的访问权限的时候。
 4. 智能指引（Smart Reference）：取代了简单指针，它在访问对象时，执行一些附加操作，它的典型用途包括：
    a. 对指向实际对象的引用计数，这样当对象没有引用时，可以自动释放它。
    b. 当第一次引用一个持久对象时，将其装入内存
    c. 在访问一个实际对象前，检查是否已经锁定了它，以确保其他对象不会改变它。
 
 ## 结构
 ![](1.JPG)
 这是一种运行时可能的代理结构对象图：
 ![](2.png)
 
 ## 参与者
 * Proxy（Image Proxy）
    1. 保存一个引用使得代理可以访问实体。若RealSubject和Subject的借口相同，Proxy会引用Subject
    2. 提供一个与Subject的接口相同的接口，这样代理就可以用来代替实体
    3. 控制对象的存取，并可能负责和删除它。
    4. 其他功能依赖于代理的类型：
        a. Remote Proxy: 负责对请求及其参数进行编码，并向不同地址空间中的实体发送已编码的请求。
        b. Virtual Proxy: 可以缓存实体的附加信息，以便延迟对它的访问。
        c. Protection Proxy: 检测调用者是否有实现一个请求所需要的访问权限。
 
 * Subject （Graphic）
    1. 定义RealSubject和Proxy的公共接口，这样就在任何使用RealSubject的地方都可以使用Proxy
 
 * RealSubject（Image）
    1. 定义Proxy所代表的的实体
 
 ## 协作
 代理根据其种类，在适当的时候想RealSubject转发请求。
 
 ## 效果
 Proxy模式在访问对象时引入了一定程度的间接性。根据代理的类型，附加的间接性有多中用途。
    1. Remote Proxy可以隐藏一个对象存在不同地址空间的事实
    2. Virtual Proxy可以更具需要，然后才创建真实对象
    3. Protection Proxy和Smart Reference 都允许在访问对象的过程当中，附加一些处理。
 
 Proxy模式可以实现copy-on-write的优化方案。拷贝一个复杂且庞大的对象是一个开销很大的操作，如果这个拷贝根本没有被修改，那么这个拷贝就不是必要的。采用Proxy模式，才进行修改之后才进行拷贝。
 
 ## 实现
 
 
 ## 相关模式
 1. Adpator模式：适配器Adaptor为它所适配的对象提供不同的接口。相反，代理提供可与它的实体相同的接口。然而有，由于保护代理可能会拒绝执行实体会执行的操作，因此，它的接口可能只是实体接口的一个子集。
 
 2. Decorator：尽管Decorator的实现部分与代理相似，但是Decorator的目的不一样。Decorator为对象添加一个或者多个功能，而代理控制对对象的访问。
 代理的实现与 decorator的实现类似，但是在相似的程度上有所差别。 Protection Proxy的实现可能与 decorator的实现差不多。另一方面， Remote Proxy不包含对实体的直接引用，而只是一个间接引用，如“主机ID，主机上的局部地址。” Virtual Proxy开始的时候使用一个间接引用，例如一个文件名，但最终将获取并使用一个直接引用。
 
 
 
 ## 其他知识点
 
 */

// 虚代理

import Foundation

protocol Graphic {
    func show()
}

struct Image: Graphic {
    func show() {
        
    }
}

struct ImageProxy: Graphic {
    
    let image: Image
    
    init(image: Image) {
        self.image = image
    }
    
    func show() {
        image.show()
    }
}

class Email {
    var image: ImageProxy?
    func display() {
        image = ImageProxy(image: Image())
    }
    func show() {
        image?.show()
    }
}


