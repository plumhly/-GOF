
/*:
 # 创建型模式的讨论
 用一个系统创建的那些对象的类对系统进行参数化有两种常用方法。一种是生成创建对象的类的子类;这对应于使用FactoryMethod(3.3)模式。这种方法的主要缺点是,仅为了改变产品类,就可能需要创建一个新的子类。这样的改变可能是级联的( cascade)。例如,如果产品的创建者本身是由一个工厂方法创建的,那么你也必须重定义它的创建者。
 
 另一种对系统进行参数化的方法更多的依赖于对象复合:定义一个对象负责明确产品对象的类,并将它作为该系统的参数。这是 Abstract Factory(3.1)、 Builder(3.2)和 Prototype (3.4)模式的关键特征。所有这三个模式都涉及到创建一个新的负责创建产品对象的“工厂对象”。 Abstract Factory由这个工厂对象产生多个类的对象。 Builder由这个工厂对象使用个相对复杂的协议,逐步创建一个复杂产品。 Prototype由该工厂对象通过拷贝原型对象来创建产品对象。在这种情况下,因为原型负责返回产品对象,所以工厂对象和原型是同一个对象。
 
 考虑在 Prototype模式中描述的绘图编辑器框架。可以有多种方法通过产品类来参数化Graphictool：
 * 使用 Factory Method模式,将为选择板中的每个 Graphici的子类创建一个 Graphictool的子类。 Graphicttool1将有一个 Newgraphici操作,每个 Graphictoolf的子类都会重定义它。
 * 使用 Abstract Factory模式,将有一个 Graphics Factory类层次对应于每个 Graphice的子类。
 在这种情况每个工厂仅创建一个产品: Circle Factory将创建 Circle, Linefactory将创建Line,等等。 Graphictool1将以创建合适种类 Graphice的工厂作为参数。
 * 使用 Prototype模式,每个 Graphic的子类将实现 Clone操作,并且 Graphic Tool!将以它所创建的 Graphic的原型作为参数。
 
 究竟哪一种模式最好取决于诸多因素。在我们的绘图编辑器框架中,第一眼看来, Factory Method模式使用是最简单的。它易于定义一个新的 Graphictoole的子类,并且仅当选择板被定义了的时候, Graphictooll的实例才被创建。它的主要缺点在于 Graphictool子类数目的激增, 并且它们都没有做很多事情。
 
 Abstract Factory并没有很大的改进,因为它需要一个同样庞大的 Graphicsfactory类层次。
 只有当早已存在一个 Graphicsfactory?类层次时, Abstract Factoryオ比 Factory Method更好一点或是因为编译器自动提供(像在 Smalltalk或是 Objective CT中)或是因为系统的其他部分需要这个 Graphics Factory类层次。
 
 总的来说, Prototype模式对绘图绵辑器框架可能是最好的,因为它仅需要为每个 Graphics 类实现一个Clne操作。这就减少了类的数目,并且 Clone可以用于其他目的而不仅仅是纯粹的实例化(例如,一个 Duplicate菜单操作)。
 
 Factory Method1使一个设计可以定制且只略微有一些复杂。其他设计模式需要新的类,而Factory Method只需要一个新的操作。人们通常将 Factory Method作为一种标准的创建对象的方法。
 但是当被实例化的类根本不发生变化或当实例化出现在子类可以很容易重定义的操作中(比如在初始化操作中)时,这就并不必要了。
 
 使用 Abstract Factory、 Prototype或 Builder的设计甚至比使用 Factory Method的那些设计更灵活,但它们也更加复杂。通常,设计以使用 Factory Method7开始,并且当设计者发现需要更大的灵活性时,设计便会向其他创建型模式演化。
 当你在设计标准之间进行权衡的时候,了解多个模式可以给你提供更多的选择余地。
 */
