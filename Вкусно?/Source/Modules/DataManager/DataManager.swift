//
//  DataManager.swift
//  Вкусно?
//
//  Created by Anton on 21.01.2023.
//

import CoreData

protocol DataManagerType: AnyObject {
	func addModel(_ model: Recipe)
	func getModels() -> [Recipe]
	func clearDataManager()
//	func deleteFromContext(model id: String)
}

final class DataManager {
	
	// MARK: - Properties
	
	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "CoreData")
		container.loadPersistentStores { storeDescription, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	private let fetchRequest = DataModel.fetchRequest()
	private lazy var context: NSManagedObjectContext = { persistentContainer.viewContext }()
	
}

// MARK: - Public Methods

extension DataManager: DataManagerType {
	
	func addModel(_ model: Recipe) {
		let managedObject = DataModel(context: context)
		managedObject.uuid = model.uuid
		managedObject.name = model.name
		managedObject.recipeDescription = model.description
		managedObject.instructions = model.instructions
		managedObject.difficulty = Int16(model.difficulty)
		saveContext()
	}
	
	func saveContext() {
		guard context.hasChanges else { return }
		do {
			try context.save()
		} catch {
			let nserror = error as NSError
			fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}

//	func deleteFromContext(model id: String) {
//		let model = context.object(with: id)// as? DataModel
//		context.delete(model)
//		saveContext()
//	}
	
	func getModels() -> [Recipe] {
		guard let models = try? context.fetch(fetchRequest) else { return [] }
		return models.map { Recipe(uuid: $0.uuid!,
									   name: $0.name!,
									   images: [],
									   description: $0.description,
									   instructions: $0.instructions!,
									   difficulty: Int($0.difficulty))
		}
//		return models
	}
	
	func clearDataManager() {
		context.reset()
	}
	
//	func updateModel(for note: DataModel) {
//		let objectToUpdate = context.object(with: note.objectID) as? DataModel
////		objectToUpdate?.title = note.title
////		objectToUpdate?.note = note.note
//		saveContext()
//	}
}
