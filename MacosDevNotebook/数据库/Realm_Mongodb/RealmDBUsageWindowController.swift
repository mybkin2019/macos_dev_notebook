//
//  RealmDBUsageWindowController.swift
//  MacosDevNotebook
//
//  Created by mabs on 02/12/2022.
//

import Cocoa
import RealmSwift

// ⚠️ 切记记得xib中配好所有 column cell 的 identifier
class RealmDBUsageWindowController: NSWindowController {
    
    // Config 是总管全局对象的配置
    // 主要配置 数据库文件路径 filePath
    // 版本 跟 数据库迁移有关 versionKey
    private let realm: Realm = {
        // 窗口实例化时自动创建了数据库
        // config可获得默认的数据库文件路径
        let config = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = config
        let rm = try! Realm(configuration: config)
        return rm
    }()
    
    @IBOutlet weak var willDeletePersonNameTF: NSTextField!
    
    @IBOutlet weak var databaseFilePathLabel: NSTextField!
    @IBOutlet weak var dogListTableView: NSTableView!
    @IBOutlet weak var personListTableView: NSTableView!
    
    @IBOutlet weak var addNewPersonNameTF: NSTextField!
    
    private var deleteDogOrPersonChooseByRadioBtn: String = "人"
    
    @IBAction func onChooseDeleteDogOrPersonTypeRadioBtnClickedAction(_ sender: NSButton) {
        print("sender.stringValue => ", sender.stringValue)
        print("sender.title => ", sender.title)
        // ⚠️ stringValue 源于 NSControl 属性 NSButton: NSControl
        // 一直都是 1 需要改用 title
        deleteDogOrPersonChooseByRadioBtn = sender.title
    }
    
    
    private var observePersonTokenNotification: NotificationToken!
    private var observeDogTokenNotification: NotificationToken!
    private var observeAllChangesTokenNotification: NotificationToken! // 初始化为 nil, 后续操作此变量会默认后面+!强制解包 比较危险的操作⚠️
    
    private var isObservingAllChanges: Bool = false {
        didSet {
            if isObservingAllChanges {
                observationStatusIndicatorLabel.stringValue = "🟢"
            } else {
                observationStatusIndicatorLabel.stringValue = "🔴"
            }
        }
    }
    
    @IBOutlet weak var observationStatusIndicatorLabel: NSTextField!
    
    @IBAction func onClickedObserveAllChangesInDBBtnAction(_ sender: Any) {
        // 需要强引用 token
        observeAllChangesTokenNotification = realm.observe { [weak self] notification, realm in
            print("notification: ", notification) // 改变会输出: didChange
                                                  // TODO: --
            switch notification {
                case .didChange:
                    print("didChange")
                case .refreshRequired:
                    print("refreshRequired")
                default:
                    print("default")
            }
            // auto updateUI
            self?.fetchAllDogs()
            self?.fetchAllPersons()
        }
        isObservingAllChanges = true
    }
    
    // TODO: -- 各种监听功能
    // 监听特定一个实例的 特定一个keyPath 的变化
    
    @IBAction func onClickedStopObserveAllChangesBtnAction(_ sender: Any) {
        guard let observeAllChangesTokenNotification = observeAllChangesTokenNotification else { return }
        // 取消 监听数据库变化
        observeAllChangesTokenNotification.invalidate()
        isObservingAllChanges = false
    }
    
    @IBAction func onClickedOpenPersonDBObservationBtnAction(_ sender: NSButton) {
        let persons = realm.objects(Person.self)
        // 可细化监听到特定的变更数据队列 DispatchQueue 还有特定的数据结构属性 keyPaths
        // persons.observe(keyPaths: ["name"], on: DispatchQueue(label: "add_queue")) { changes in
            
        // }
        // DispatchQueue.main 主队列
        // TODO: --
        observePersonTokenNotification = persons.observe { (changes: RealmCollectionChange<Results<Person>>) -> () in
            print(changes)
            // changes 是改变后所有的数据集合还有
            // Person 数据集合 , deletions: [], insertions: [11], modifications: [])
            
            switch changes {
                case .error(let err):
                    print(err.localizedDescription)
                case .update(let resultsAfterUpdating, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    print("..")
                default:
                    print("default")
            }
        }
    }
    
    @IBAction func onClickedOpenDogDBObservationBtnAction(_ sender: NSButton) {
        let dogs = realm.objects(Dog.self)
        
        observeDogTokenNotification = dogs.observe({ changes in
            print(changes)
        })
    }
    
    @IBAction func onClickedAsyncWriteMaryHaryBtnAction(_ sender: NSButton) {
        // print(#function)
        
        let persons = realm.objects(Person.self)
        let theOne = persons.where { p in
            p.name == "Mary"
        }
        guard theOne.isEmpty else {
            showPopoverTips(with: "Mary/Hary已经存在😜", of: sender)
            return
        }
        
        let mary = Person(name: "Mary", age: Int.random(in: 1..<99))
        let hary = Person(name: "Hary", age: Int.random(in: 1..<99))
        
        let dogMary = Dog(name: "MayMay", age: Int.random(in: 1...20))
        let dogMary1 = Dog(name: "MayHay", age: Int.random(in: 1...20))
        let dogHary = Dog(name: "HayHay", age: Int.random(in: 1...20))
        let dogHary1 = Dog(name: "HayMay", age: Int.random(in: 1...20))
        mary.pets.append(dogMary)
        hary.pets.append(dogHary)
        mary.pets.append(dogMary1)
        hary.pets.append(dogHary1)
        
        // ⚠️关键方法
        realm.writeAsync { [weak self] in
            self?.realm.add(mary)
            self?.realm.add(hary)
            print("Current thread: ", Thread.current)
        } onComplete: { [weak self] err in
            if nil != err {
                self?.showPopoverTips(with: err!.localizedDescription, of: sender)
            } else {
                self?.showPopoverTips(with: "🎉成功添加Hary/Mary🎉", of: sender)
            }
        }
    }
    
    private func showPopoverTips(with tipString: String, of view: NSView) {
        let popoverVC = PopoverTipsViewController(nibName: nil, bundle: nil)
        let pop = NSPopover()
        pop.behavior = .transient
        pop.contentViewController = popoverVC
        pop.show(relativeTo: view.bounds, of: view, preferredEdge: .minY)
        // 应该是 contentViewController 对 popVC 强引用
        // 当前show对pop进行强引用
        // show之后才会实例化 view 才会有 tipsLabel
        // 结束show之后所有vc popover 才会释放内存
        popoverVC.tipsLabel.stringValue = tipString
    }
    
    @IBAction func onClickedOnlyQueryAllPersonsAction(_ sender: NSButton) {
        fetchAllPersons()
    }
    @IBAction func onClickedOnlyQueryAllDogsBtnAction(_ sender: NSButton) {
        fetchAllDogs()
    }
    
    @IBAction func onClickedAddNewPersonWithNameAndRandomDogBtnAction(_ sender: NSButton) {
        
        let newPersonName = addNewPersonNameTF.stringValue
        
        guard !newPersonName.isEmpty else {
            // addNewPersonNameTF.resignFirstResponder()
            addNewPersonNameTF.placeholderString = "⚠️人名不可为空⚠️"
            return
        }
        
        let newPerson = Person(name: newPersonName, age: Int.random(in: 10...99))
        let newDog = Dog(name: ["小黑", "小红",
                                "小绿", "小黄",
                                "大白", "憨憨"].randomElement()!, age: Int.random(in: 1...20))
        newPerson.pets.append(newDog)
        
        // 判断是否有重名人员
        let existedPersons = realm.objects(Person.self)
        let theSameNameOne = existedPersons.where { p in
            p.name == newPersonName
        }
        if !theSameNameOne.isEmpty {
            // 存在
            newPerson.name += "+\(theSameNameOne.count)S"
        }
        
        do {
            try realm.write {
                realm.add(newPerson)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        fetchAllPersons()
        fetchAllDogs()
    }
    
    private var personListDataSource: PersonListTableViewDiffDataSource!
    private var dogListDataSource: DogListTableViewDiffableDataSource!
    
    @IBAction func onClickedPrintDBFilePathBtnAction(_ sender: Any) {
        databaseFilePathLabel.stringValue = realm.configuration.fileURL?.path ?? "无法获取路径"
    }
    
    @IBAction func onClickedCreateDataBtnAction(_ sender: NSButton) {
        let persons = realm.objects(Person.self)
        let sam = persons.where { query in
            query.name == "Sam"
        }
        if !sam.isEmpty { print("Sam存在了"); return}
        let person = Person(name: "Sam", age: 18)
        let dog = Dog(name: "旺旺", age: 2)
        let pets = List<Dog>()
        pets.append(dog)
        person.pets = pets
        do {
            try realm.write {
                realm.add(person)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func onClickedQueryAllPersonsAndDogsBtnAction(_ sender: Any) {
        // print(#function)
        fetchAllPersons()
        fetchAllDogs()
    }
    
    @IBAction func onClickedDeletePersonWithNameBtnAction(_ sender: Any) {
        let willDeletePersonOrDogName = willDeletePersonNameTF.stringValue
        guard !willDeletePersonOrDogName.isEmpty else {
            willDeletePersonNameTF.placeholderString = "😁请输入需要删除的对象名称😁"
            willDeletePersonNameTF.stringValue = ""
            return
        }
        
        switch deleteDogOrPersonChooseByRadioBtn {
            case "人":
                let persons = realm.objects(Person.self)
                let deleteOne = persons.where { person in
                    let res = person.name == willDeletePersonOrDogName
                    return res
                }
                do {
                    try realm.write {
                        realm.delete(deleteOne)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case "狗":
                let dogs = realm.objects(Dog.self)
                let deleteOne = dogs.where { dog in
                    let res = dog.name == willDeletePersonOrDogName
                    return res
                }
                do {
                    try realm.write {
                        realm.delete(deleteOne)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            default:
                willDeletePersonNameTF.placeholderString = "❎删除失败❎"
                return
        }
        // updateUI
        willDeletePersonNameTF.stringValue = ""
        willDeletePersonNameTF.placeholderString = "😁请输入需要删除的对象名称😁"
        fetchAllPersons()
        fetchAllDogs()
    }
    
    @objc private func tableViewDoubleClickedAction(_ sender: Any) {
        print(#function)
        print("double click sender: ", sender) // NSTableview
        // 在 tableView 任何地方双击都会触发
        
        guard let sender = sender as? NSTableView else { return }
        // 获取点击过的 row
        // 获取点击过的 column
        print("clicked row: ", sender.clickedRow)
        print("clicked column: ", sender.clickedColumn)
        // 没有选中的时候输出 -1 -1
        // 选中的时候可以精确定位到 cell (column + row)
        print("selected cell: ", personListTableView.selectedCell())
    }
    
    private func setBinding() {
        personListTableView.doubleAction = #selector(tableViewDoubleClickedAction(_:))
        personListTableView.delegate = self
        personListDataSource = PersonListTableViewDiffDataSource(tableView: personListTableView, cellProvider: { (tableView, tableColumn, row, person) -> NSView in
            // 设置对应的cell数据
            switch tableColumn.identifier.rawValue {
                case PersonListTableViewColumnIdentifierType.personNameColumnIdentifier.rawValue:
                    let nameCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(PersonListTableViewCellIdentifierType.personNameCellIdentifier.rawValue), owner: nil) as? NSTableCellView
                    nameCell?.textField?.stringValue = person.name
                    return nameCell!
                case PersonListTableViewColumnIdentifierType.personAgeColumnIdentifier.rawValue:
                    let ageCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(PersonListTableViewCellIdentifierType.personAgeCellIdentifier.rawValue), owner: nil) as? NSTableCellView
                    ageCell?.textField?.stringValue = "\(person.age)"
                    return ageCell!
                default:
                    return NSView()
            }
        })
        personListTableView.dataSource = personListDataSource
        
        dogListTableView.delegate = self
        dogListDataSource = DogListTableViewDiffableDataSource(tableView: dogListTableView,
                                                               cellProvider: { tableView, tableColumn, row, dog in

            switch tableColumn.identifier.rawValue {
                case DogListTableViewColumnIdentifierType.dogNameColumnIdentifier.rawValue:
                    let dogNameCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(DogListTableViewCellIdentifierType.dogNameCellIIdentifier.rawValue), owner: nil) as? NSTableCellView
                    dogNameCell?.textField?.stringValue = dog.name
                    // 💉 注入 objectValue
                    dogNameCell?.objectValue = dog
                    return dogNameCell!
                    
                case DogListTableViewColumnIdentifierType.dogOwnerNameColumnIdentifier.rawValue:
                    let persons = self.realm.objects(Person.self)
                    // print(dog)
                    let owner = persons.where { person in
                        return person.pets.contains(dog)
                    }
                    // print(owner)
                    let ownerNameCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(DogListTableViewCellIdentifierType.dogOwnerNameCellIIdentifier.rawValue), owner: nil) as? NSTableCellView
                    ownerNameCell?.textField?.stringValue = owner.first?.name ?? "no owner"
                    
                    return ownerNameCell!
                    
                case DogListTableViewColumnIdentifierType.dogAgeColumnIdentifier.rawValue:
                    let dogAgeCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(DogListTableViewCellIdentifierType.dogAgeCellIIdentifier.rawValue), owner: nil) as? NSTableCellView
                    dogAgeCell?.textField?.stringValue = "\(dog.age)"
                    return dogAgeCell!
                default:
                    return NSView()
            }
        })
    
        dogListTableView.dataSource = dogListDataSource
    }
    
    private func configure(with persons: [Person]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Person>()
        snapshot.appendSections([0])
        snapshot.appendItems(persons, toSection: 0)
        
        personListDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        setBinding()
    }
    
    private func fetchAllPersons() {
        let persons = Array(realm.objects(Person.self))
        configure(with: persons)
    }
    
    private func fetchAllDogs() {
        let dogs = Array(realm.objects(Dog.self))
        configure(with: dogs)
    }
    
    private func configure(with dogs: [Dog]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Dog>()
        snapshot.appendSections([0])
        snapshot.appendItems(dogs)
        
        dogListDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // [BEGIN] 切记在Xib文件中设置 ColumnID CellID
    enum PersonListTableViewColumnIdentifierType: String, CaseIterable {
        case personNameColumnIdentifier
        case personAgeColumnIdentifier
    }
    
    enum PersonListTableViewCellIdentifierType: String, CaseIterable {
        case personNameCellIdentifier
        case personAgeCellIdentifier
    }
    
    enum DogListTableViewColumnIdentifierType: String, CaseIterable {
        case dogNameColumnIdentifier
        case dogOwnerNameColumnIdentifier
        case dogAgeColumnIdentifier
    }
    
    enum DogListTableViewCellIdentifierType: String, CaseIterable {
        case dogNameCellIIdentifier
        case dogOwnerNameCellIIdentifier
        case dogAgeCellIIdentifier
    }
    // 切记在Xib文件中设置 ColumnID CellID [END]
    
    deinit {
        // 需要强引用 controller 否则会自动销毁
        print("windowController 销毁了")
    }
}

extension RealmDBUsageWindowController: NSTableViewDelegate /* NSTableViewDataSource */ {
    // ⚠️一旦使用了 diff 数据源 就需要在 diff dataSource 实例化的时候给每个cell 通过
    // cell.valueObject = 赋值
    // 给每个cell设置自己特定的 valueObject
    // 下面方法仅仅是通过传统的 tableView.dataSource = self 的时候
    // 通过遵守 NSTableViewDataSource 协议 然后重写实现下面方法
    // func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
       // print("给每个cell 💉 注入valueObject...")
       // return "value of : \(tableColumn?.title.description) + at row: \(row)"
    // }
}

// Int SectionIdentifier!
class PersonListTableViewDiffDataSource: NSTableViewDiffableDataSource<Int, Person> {
    
    deinit {
        print(#function, #line, "RealmUsagePersonListTableView 数据源销毁了")
    }
}


class DogListTableViewDiffableDataSource: NSTableViewDiffableDataSource<Int, Dog> {
    deinit {
        print(#function, #line, "Dog 数据源销毁了")
    }
}
