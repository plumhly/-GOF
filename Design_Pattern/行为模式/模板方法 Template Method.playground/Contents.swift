/*:
 # 迭代器 - Iterator  -- 类行为型模式
 
 ## 意图
 定义一个操作中的算法的骨架,而将一些步骤延迟到子类中。 Templatemethod使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。
 
 ## 动机
 考虑一个提供 Application和 Document类的应用框架。 Application类负责打开一个已有的以外部形式存储的文档,如一个文件。一旦一个文档中的信息从该文件中读出后,它就由个 Document对象表示。
 用框架构建的应用可以通过继承Application和Document来满足特定的需求。例如,一个绘图应用定义 Drawapplication和 Drawdocument-子类;一个电子表格应用定义 Spreadsheet Application和 Spreadsheetdocument子类,如下页图所示。
 抽象的 Application类在它的 Open Document操作中定义了打开和读取一个文档的算法:
 ```swift
 class Application {
     func openDocument(name: String) {
          let doc = createDoc()
          doc.do1()
          doc.do2()
     }
 }
 ```
 ![](1.png)
 
 OpenDocument定义了打开ー个文档的每一个主要步骤。它检査该文档是否能被打开,创建与应用相关的 Document对象,将它加到它入的文档集合中,并且从一个文件中读取该Document。
 我们称OpenDocument为一个模板方法(template method)。一个模板方法用一些抽象的操作定义一个算法,而子类将重定义这些操作以提供具体的行为。Application的子类将定义检査一个文档是否能够被打开(CanOpendocument)和创建文档( Docreatedocument)的具体算法步骤。 Document-子类将定义读取文档(Doread)的算法步骤。如果需要,模板方法也可定义一个操作(AboutToOpen Document)让 Application子类知道该文档何时将被打开。
 通过使用抽象操作定义一个算法中的一些步骤,模板方法确定了它们的先后顺序,但它允许 Application和 Document子类改变这些具体步骤以满足它们各自的需求。
 
 
 ## 适用性
 模板方法应用于下列情况
 * 一次性实现一个算法的不变的部分,并将可变的行为留给子类来实现。
 * 各子类中公共的行为应被提取出来并集中到一个公共父类中以避免代码重复。这是Opdyke和Johnson所描述过的“重分解以一般化”的一个很好的例子[OJ93]。首先识别现有代码中的不同之处,
 并且将不同之处分离为新的操作。最后,用一个调用这些新的操作的模板方法来替换这些不同的代码。
 * 控制子类扩展。模板方法只在特定点调用“hook”操作(参见效果一节),这样就只允许在这些点进行扩展。
 
 
 ## 结构
 ![](2.png)
 
 ## 参与者
 -- Abstractclass(抽象类,如 Application）
 * 定义抽象的原语操作( primitive operation),具体的子类将重定义它们以实现一个算法的各个步骤。
 * 实现一个模板方法,定义一个算法的骨架。该模板方法不仅调用原语操作,也调用定义在 Abstractclass或其他对象中的操作。
 
 -- ConcreteClass(具体类,如 MyApplication）
 * 实现原语操作以完成算法中与特定子类相关的步骤。
 
 ## 协作
 Concrete Classi靠 Abstractclass来实现算法中不变的步骤。
 
 ## 效果
 模板方法导致一种反向的控制结构,这种结构有时被称为“好菜坞法则”,即“别找我们, 我们找你”[Swe85]。这指的是一个父类调用一个子类的操作,而不是相反。
 模板方法调用下列类型的操作:
 * 具体的操作(Concreteclasse或对客户类的操作)。
 * 具体的AbstractClass的操作(即,通常对子类有用的操作)。
 * 原语操作(即,抽象操作)。
 * Factory Method(参见 Factory Method(3.5)
 * 钩子操作( hook operations),它提供了缺省的行为,子类可以在必要时进行扩展。一个钩子操作在缺省操作通常是一个空操作。
 很重要的一点是模板方法应该指明哪些操作是钩子操作(可以被重定义)以及哪些是抽象操作(必须被重定义)。要有效地重用一个抽象类,子类编写者必须明确了解哪些操作是设计为有待重定义的
 
 
 ## 实现
 有三个实现问题值得注意:
 1) 使用C++访问控制在C++中,一个模板方法调用的原语操作可以被定义为保护成员。这保证它们只被模板方法调用。必须重定义的原语操作须定义为纯虚函数。
 模板方法自身不暠被重定义;因此可以将模板方法定义为一个非虚成员函数冬。
 2) 尽量减少原语操作定义模板方法的一个重要目的是尽量减少一个子类具体实现该算时必须重定义的那些原语操作的数目。需要重定义的操作越多,客户程序就越冗长。
 3) 命名约定可以给应被重定义的那些操作的名字加上一个前缀以识别它们。例如,用于 Macintosh应用的 Macappf框架[AP8)给模板方法加上前缀“Do-",如“ Docreatedocument", “ Doread”,等等。
 
 
 ## 相关模式
 
 
 
 ## 其他知识点
 
 */

import Cocoa

protocol Cook {
    func cook()
    
    func wash()
    func cut()
    func fire()
}

extension Cook {
    func cook() {
        wash()
        cut()
        fire()
    }
}

class CaiTou: Cook {
    func wash() {
        
    }
    
    func cut() {
        
    }
    
    func fire() {
        
    }
}

class Rouse: Cook {
    func wash() {
        
    }
    
    func cut() {
        
    }
    
    func fire() {
        
    }
}
