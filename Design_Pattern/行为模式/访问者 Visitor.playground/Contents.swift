/*:
 # 访问者 - Visitor  -- 对象行为型模式
 
 ## 意图
 表示一个作用于某对象结构中的各元素的操作。它使你可以在不改变各元素的类的前提下定义作用于这些元素的新操作。
 
 ## 动机
 考虑一个编译器,它将源程序表示为一个抽象语法树。该编译器需在抽象语法树上实施某些操作以进行“静态语义”分析,例如检査是否所有的变量都已经被定义了。它也需要生成代码。因此它可能要定义许多操作以进行类型检査、代码优化、流程分析,检査变量是否在使用前被赋初值,等等。此外,还可使用抽象语法树进行优美格式打印、程序重构、code instrumentation以及对程序进行多种度量。
 
 这些操作大多要求对不同的节点进行不同的处理。例如对代表赋值语句的结点的处理就不同于对代表变量或算术表达式的结点的处理。因此有用于赋值语句的类,有用于变量访问的类,还有用于算术表达式的类,等等。结点类的集合当然依赖于被编译的语言,但对于ー个给定的语言其变化不大。
 
 ![](1.png)
 
 上面的框图显示了Node类层次的一部分。这里的问题是,将所有这些操作分散到各种结点类中会导致整个系统难以理解、难以维护和修改。将类型检査代码与优美格式打印代码或流程分析代码放在一起,将产生混乱。此外,增加新的操作通常暠要重新编译所有这些类。如果可以独立地增加新的操作,并且使这些结点类独立于作用于其上的操作,将会更好一些。
 
 
 使用 Visitor模式,必须定义两个类层次:一个对应于接受操作的元素(Node层次)另个对应于定义对元素的操作的访问者(NodeVisitor)层次)。给访问者类层次增加一个新的子类即可创建一个新的操作。
 只要该编译器接受的语法不改变(即不需要增加新的Node子类),我们就可以简单的定义新的 NodeVisitor子类以增加新的功能。
 
 ![](2.png)
 
 ## 适用性
 在下列情况下使用Visitor模式:
 * 一个对象结构包含很多类对象,它们有不同的接口,而你想对这些对象实施一些依赖于其具体类的操作。
 * 需要对一个对象结构中的对象进行很多不同的并且不相关的操作,而你想避免让这些操作“污染”这些对象的类。 Visitor使得你可以将相关的操作集中起来定义在一个类中。
 当该对象结构被很多应用共享时,用 Visitort模式让每个应用仅包含需要用到的操作。
 * 定义对象结构的类很少改变,但经常需要在此结构上定义新的操作。改变对象结构类需要重定义对所有访问者的接口,这可能需要很大的代价。如果对象结构类经常改变,那么可能还是在这些类中定义这些操作较好。
 
 
 ## 结构
 
 ![](3.png)
 
 ## 参与者
 -- Visitor(访问者,如NodeVisitor)
 * 为该对象结构中 Concreteelemente的每一个类声明一个 Visit操作。该操作的名字和特征标识了发送 Visit请求给该访问者的那个类。这使得访问者可以确定正被访问元素的具体的类。这样访问者就可以通过该元素的特定接口直接访问它。
 
 -- Concretevisitor(具体访问者,如TypecheckingVisitor)
 * 实现每个由Visitor声明的操作。每个操作实现本算法的一部分,而该算法片断乃是对应于结构中对象的类。 Concrete Visitor为该算法提供了上下文并存储它的局部状态。这一状态常常在遍历该结构的过程中累积结果。
 
 -- Element(元素,如Node)
 * 定义一个 Accepti操作,它以一个访问者为参数。
 
 -- ConcreteElement(具体元素,如Assignmentnode, Variablerefnode)
 * 实现 Accept操作,该操作以一个访问者为参数。
 
 -- Objectstructure(对象结构,如Program)
 * 能枚举它的元素。
 * 可以提供一个高层的接口以允许该访问者访问它的元素。
 * 可以是一个复合(参见 Composite(4.3))或是一个集合,如一个列表或一个无序集合
 
 ## 协作
 * 一个使用 Visitor/模式的客户必须创建一个 oncrete Visitor,对象,然后遍历该对象结构, 并用该访问者访问每一个元素。
 * 当一个元素被访问时,它调用对应于它的类的 Visitor操作。如果必要,该元素将自身作为这个操作的一个参数以便该访问者访问它的状态。
 
 下面的交互框图说明了一个对象结构、一个访问者和两个元素之间的协作。
 
 ![](4.png)
 
 ## 效果
 下面是访问者模式的一些优缺点:
 1) 访问者模式使得易于增加新的操作。访问者使得增加依赖于复杂对象结构的构件的操作变得容易了。仅需增加一个新的访问者即可在一个对象结构上定义一个新的操作。相反, 如果每个功能都分散在多个类之上的话,定义新的操作时必须修改每一类。
 
 2) 访问者集中相关的操作而分离无关的操作。相关的行为不是分布在定义该对象结构的各个类上,而是集中在一个访问者中。无关行为却被分别放在它们各自的访问者子类中。
 这就既简化了这些元素的类,也简化了在这些访问者中定义的算法。所有与它的算法相关的数椐结构都可以被隐藏在访问者中。
 
 3) 増加新的 Concreteelement类很困难。Visitor模式使得难以增加新的 Elementi的子类。每添加一个新的ConcreteElement都要在Vistor中添加一个新的抽象操作,并在每一个Concretvisitor类中实现相应的操作。有时可以在 Visitor中提供一个缺省的实现,这一实现可以被大多数的 Concretevisitory继承,但这与其说是一个规律还不如说是一种例外。
 所以在应用访问者模式时考虑关键的问题是系统的哪个部分会经常变化,是作用于对象结构上的算法呢还是构成该结构的各个对象的类。如果老是有新的 Concretelement类加入进来的话, Vistor类层次将变得难以维护。在这种情况下,直接在构成该结构的类中定义这些操作可能更容易一些。如果Element类层次是稳定的,而你不断地增加操作获修改算法,访问者模式可以帮助你管理这些改动。
 
 4) 通过类层次进行访问。一个迭代器(参见 Iterator(5.4))可以通过调用节点对象的特定操作来遍历整个对象结构,同时访问这些对象。但是迭代器不能对具有不同元素类型的对象结构进行操作。例如,定义在第5章的 Iterator接口只能访问类型为Iem的对象:
     ```
     class Item {
        var currentItem: Item?
     }
     ```
     这就意味着所有该迭代器能够访问的元素都有一个共同的父类Item。
     访问者没有这种限制。它可以访问不具有相同父类的对象。可以对一个 Visitor接口增加任何类型的对象。例如,在
     
     ```
     class MyType {}

     class YourType {}

     class Vistor {
         func visit(item: MyType) {}
         func visit(item: YourType) {}
     }
     ```
     中, Mytype和 Yourtlype可以完全无关,它们不必继承相同的父类。
 
 5) 累积状态。当访问者访问对象结构中的每一个元素时,它可能会累积状态。如果没有访问者,这一状态将作为额外的参数传递给进行遍历的操作,或者定义为全局变量。
 6) 破坏封装。访问者方法假定 Concreteelementf接口的功能足够强,足以让访问者进行它们的工作。结果是,该模式常常迫使你提供访问元素内部状态的公共操作,这可能会破坏它的封装性
 
 ## 实现
 1) 双分派(Double-Dispatch)访问者模式允许你不改变类即可有效地增加其上的操作。为达到这一效果使用了一种称为双分派(Double-Dispatch)的技术。这是一种很著名的技术。事实上,一些编程语言甚至直接支持这一技术(例如,CLOS)。
 而象C++和 Smalltalk这样的语言支持单分派(Single-Dispatch)在单分派语言中,到底由哪一种操作将来实现一个请求取决于两个方面:该请求的名和接收者的类型。
 
 2) 谁负责遍历对象结构一个访问者必须访问这个对象结构的每一个元素。问题是,它怎样做?我们可以将遍历的责任放到下面三个地方中的任意一个:对象结构中,访问者中, 或一个独立的迭代器对象中(参见Iterator(5.4))
 
    通常由对象结构负责迭代。一个集合只需对它的元素进行迭代,并对每一个元素调用Accept操作。而一个复合通常让Accept操作遍历该元素的各子构件并对它们中的每一个递归地调用Accept 另一个解决方案是使用一个迭代器来访问各个元素。
 在C++中,既可以使用内部迭代器也可以使用外部迭代器,到底用哪一个取决于哪一个可用和哪一个最有效。在Smalltalk中,通常使用一个内部迭代器,这个内部迭代器使用do:和一个块。因为内部迭代器由对象结构实现, 使用一个内部迭代器很大程度上就像是让对象结构负责迭代。主要区别在于一个内部迭代器不会产生双分派一一它将以该元素为一个参数调用访问者的一个操作而不是以访问者为参数调用元素的一个操作。不过,如果访问者的操作仅简单地调用该元素的操作而无需递归的话, 使用一个内部迭代器的Visitort模式很容易使用。
 
    甚至可以将遍历算法放在访问者中,尽管这样将导致对每一个聚合ConcreteElement,在每一个 ConcreteVisitor中都要复制遍历的代码。将该遍历策略放在访问者中的主要原因是想实现一个特别复杂的遍历,它依赖于对该对象结构的操作结果。
 
 ## 相关模式
 * Composite(4.3):访问者可以用于对一个由 Composite模式定义的对象结构进行操作。
 * Interpreter(5.3):访问者可以用于解释。
 
 
 ## 其他知识点
 
 */

import Cocoa


protocol Visitor {
    func visitElementA(element: ElementA)
    func visitElementB(element: ElementB)
}

class PrettyPrintVisitorA: Visitor {
    func visitElementA(element: ElementA) {
        
    }
    
    func visitElementB(element: ElementB) {
        
    }
}


class TypeCheckVisitorA: Visitor {
    func visitElementA(element: ElementA) {
        
    }
    
    func visitElementB(element: ElementB) {
        
    }
}


protocol Element {
    func accept(vistor: Visitor)
}

struct ElementA: Element {
    func accept(vistor: Visitor) {
        vistor.visitElementA(element: self)
    }
}

struct ElementB: Element {
    func accept(vistor: Visitor) {
        vistor.visitElementB(element: self)
    }
}


class ObjectStructure {
    
    var elementA: ElementA?
    var elementB: ElementB?
    
    func pretyPrint() {
        let prettyPrintVisitor = PrettyPrintVisitorA()
        elementA?.accept(vistor: prettyPrintVisitor)
        elementB?.accept(vistor: prettyPrintVisitor)
    }
    
    func typeCheck() {
        let typeCheckVisitorA = TypeCheckVisitorA()
        elementA?.accept(vistor: typeCheckVisitorA)
        elementB?.accept(vistor: typeCheckVisitorA)
    }
}
