//
//  CoreDataService.swift
//  Вкусно?
//
//  Created by Anton on 23.01.2023.
//

import CoreData

protocol CoreDataServiceType: AnyObject {
	func addModel(with name: String)
	func saveContext()
	func getModels() -> [CoreDataModel]
//	func deleteFromContext(person: Person)
//	func updateModel(for person: Person)
}

final class CoreDataService {
	
	// MARK: - Singleton
	
	static let shared = CoreDataService.init()
	private init() { }
	
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
	
	private let fetchRequest = CoreDataModel.fetchRequest()
	private lazy var context: NSManagedObjectContext = { persistentContainer.viewContext }()
	
}

// MARK: - Public Methods

extension CoreDataService {
	
	public func addModel() {
		let managedObject = CoreDataModel(context: context)
//		managedObject.title = String()
//		managedObject.note = String()
		saveContext()
	}
	
	public func saveContext() {
		guard context.hasChanges else { return }
		do {
			try context.save()
		} catch {
			let nserror = error as NSError
			fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}

	public func deleteFromContext(model id: String) {
//		context.delete(note)
		saveContext()
	}
	
	public func getModels() -> [CoreDataModel] {
		guard let models = try? context.fetch(fetchRequest) else { return [] }
		return models
	}
	
	public func updateModel(for note: CoreDataModel) {
		let objectToUpdate = context.object(with: note.objectID) as? CoreDataModel
//		objectToUpdate?.title = note.title
//		objectToUpdate?.note = note.note
		saveContext()
	}
}
