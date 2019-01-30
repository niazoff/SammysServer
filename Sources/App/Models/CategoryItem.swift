import Vapor
import FluentPostgreSQL

final class CategoryItem: PostgreSQLUUIDPivot, ModifiablePivot {
	typealias Left = Category
	typealias Right = Item
	
	static let leftIDKey: LeftIDKey = \.categoryID
	static let rightIDKey: RightIDKey = \.itemID
	
	var id: CategoryItem.ID?
	var categoryID: Category.ID
	var itemID: Item.ID
	
	var description: String?
	var price: Double?
	
	init(_ category: Left, _ item: Right) throws {
		self.categoryID = try category.requireID()
		self.itemID = try item.requireID()
	}
}

extension CategoryItem: Migration {}

extension CategoryItem {
	var modifiers: Children<CategoryItem, Modifier> {
		return children(\.parentCategoryItemID)
	}
}
