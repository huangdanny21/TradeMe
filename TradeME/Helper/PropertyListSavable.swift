//
//  PropertyListSavable.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/19/23.
//

public protocol PropertyListable {
    associatedtype PropertyListType
    var propertyListRepresentation : PropertyListType { get }
    init(propertyList : PropertyListType)
}

extension String : PropertyListable {
    public typealias PropertyListType = String
    public var propertyListRepresentation : PropertyListType { return self }
    public init(propertyList: PropertyListType) { self.init(stringLiteral: propertyList) }
}

extension Int : PropertyListable {
    public typealias PropertyListType = Int
    public var propertyListRepresentation : PropertyListType { return self }
    public init(propertyList: PropertyListType) { self.init(propertyList) }
}

// Archive

//let currentState = SMState<Foo>(Foo.north)
//let stateEncodeData = NSKeyedArchiver.archivedData(withRootObject: currentState)

// Un-Archive

//let restoredState = NSKeyedUnarchiver.unarchiveObject(with: stateEncodeData) as! SMState<Foo>
//print(restoredState.value)
