//
//  HouseViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/10/16.
//  Copyright © 2016 David Johnson. All rights reserved.
//

import Cocoa

/// A view controller to show the houses and person and allow the user to perform data operations on them.
class HouseViewController: NSViewController {
	
	var managedContext = (NSApplication.shared.delegate as! AppDelegate).managedObjectContext

	@IBOutlet var labelCount: NSTextField!
	@IBOutlet var labelCountValue: NSTextField!
	
	@IBOutlet var tableHouses: NSTableView!
	@IBOutlet var tablePersons: NSTableView!
	
	@IBOutlet weak var btnAddHouse: NSButton!
	@IBOutlet weak var btnAddHouseTouchBar: NSButton!
    @IBOutlet weak var btnUpdateHouse: NSButton!
    @IBOutlet weak var btnDeleteHouse: NSButton!
	
    @IBOutlet weak var btnAddPerson: NSButton!
	@IBOutlet weak var btnAddPersonTouchBar: NSButton!
    @IBOutlet weak var btnUpdatePerson: NSButton!
    @IBOutlet weak var btnDeletePerson: NSButton!
	
	fileprivate let houseDao = HouseDao()
	fileprivate let personDao = PersonDao()
	fileprivate var currentHouse:House? = nil
	fileprivate var currentPerson:Person? = nil
	
	lazy var houseEditViewController: HouseEditViewController =
	{
			return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "HouseEditViewController")) as! HouseEditViewController
	}()
	
	lazy var personEditViewController: PersonEditViewController =
	{
			return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PersonEditViewController")) as! PersonEditViewController
	}()
	
    override func viewDidLoad() {
		
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Houses view did load")
		
		self.tableHouses.delegate = self
		self.tableHouses.dataSource = self
		
		self.tablePersons.delegate = self
		self.tablePersons.dataSource = self
		
		self.enableHouseControls(isEnabled: false)
		self.enablePersonControls(isAddEnabled: false, isUpdateDeleteEnabled: false)
    }

	override func keyDown(with event: NSEvent) {
		
		switch event.modifierFlags.intersection(.deviceIndependentFlagsMask)
		{
		case [.command] where event.characters == "a", [.command, .shift] where event.characters == "a":
			btnAddHouse_Action(NSButton())
		case [.command] where event.characters == "u", [.command, .shift] where event.characters == "u":
			btnUpdateHouse_Action(NSButton())
		case [.command] where event.characters == "d", [.command, .shift] where event.characters == "d":
			btnDeleteHouse_Action(NSButton())
		case [.command] where event.characters == "p", [.command, .shift] where event.characters == "p":
			btnAddPerson_Action(NSButton())
		case [.command] where event.characters == "i", [.command, .shift] where event.characters == "i":
			btnUpdatePerson_Action(NSButton())
		case [.command] where event.characters == "e", [.command, .shift] where event.characters == "e":
			btnDeletePerson_Action(NSButton())
		default:
			break
		}
	}
    
    /// Button action to add a house.
    ///
    /// - Parameter sender: the view's button
    @IBAction func btnAddHouse_Action(_ sender: NSButton) {
        NSLog("add house action")
		self.currentHouse = self.houseDao.create(contact: "", phone: "")
		self.performHouseDataAction(operation: .Add)
    }
    
    /// Button action to modify a house.
    ///
    /// - Parameter sender: the view's button
    @IBAction func btnUpdateHouse_Action(_ sender: NSButton) {
        NSLog("update house action")
		
		if self.currentHouse != nil {
			self.performHouseDataAction(operation: .Update)
		} else {
			NSLog("No house selected")
			showOkMessage(title:"Data", message:"House not selected.")
		}
		
    }

    /// Button action to delete a house.
    ///
    /// - Parameter sender: the view's button
    @IBAction func btnDeleteHouse_Action(_ sender: NSButton) {
        NSLog("delete house action")
		
		if self.currentHouse != nil {
			self.performHouseDataAction(operation: .Delete)
		} else {
			NSLog("No house selected")
			showOkMessage(title:"Data", message:"House not selected.")
		}
    }
    
    /// Button action to add a person.
    ///
    /// - Parameter sender: the view's button
    @IBAction func btnAddPerson_Action(_ sender: NSButton) {
        NSLog("add person action")
		
		if self.currentHouse != nil {
			self.currentPerson = self.personDao.create(house: self.currentHouse!)
			
			if self.currentPerson != nil {
				self.performPersonDataAction(operation: .Add)
			} else {
				NSLog("a person was nt created")
			}
		} else {
			NSLog("There isn't a current house")
			showOkMessage(title:"Data", message:"House not selected.")
		}
    }
    
    /// Button action to modify a person.
    ///
    /// - Parameter sender: the view's button
    @IBAction func btnUpdatePerson_Action(_ sender: NSButton) {
        NSLog("update person action")
		
		if self.currentPerson != nil {
        	self.performPersonDataAction(operation: .Update)
		} else {
			NSLog("There isn't a current person")
			showOkMessage(title:"Data", message:"Person not selected.")
		}
    }
    
    /// Button action to delete a person.
    ///
    /// - Parameter sender: the view's button
    @IBAction func btnDeletePerson_Action(_ sender: NSButton) {
        NSLog("delete person action")
		
		if self.currentPerson != nil {
        	self.performPersonDataAction(operation: .Delete)
		} else {
			NSLog("There isn't a current person")
			showOkMessage(title:"Data", message:"Person not selected.")
		}
    }
	
	/// Enable or disable the house controls depending on if a house is selected. The add button is always enabled.
	///
	/// - Parameter isEnabled: flag if the update and delete button are enabled
	fileprivate func enableHouseControls(isEnabled:Bool) {
		self.btnUpdateHouse.isEnabled = isEnabled
		self.btnDeleteHouse.isEnabled = isEnabled
	}
	
	/// Enable or disable the person buttons depending on if a house is selected and if there are persons associated with the house.
	///
	/// - Parameters:
	///   - isAddEnabled: flag if the add button should be enabled
	///   - isUpdateDeleteEnabled: flag if the update and delete buttons are enabled.
	fileprivate func enablePersonControls(isAddEnabled:Bool, isUpdateDeleteEnabled:Bool) {
		self.btnAddPerson.isEnabled = isAddEnabled
		self.btnAddPersonTouchBar.isEnabled = isAddEnabled
		self.btnUpdatePerson.isEnabled = isUpdateDeleteEnabled
		self.btnDeletePerson.isEnabled = isUpdateDeleteEnabled
	}
	
	/// Create the data operation on a house, the object to manipulate and open the sheet to perform the operation.
	fileprivate func performHouseDataAction(operation:DataOperation) {
		self.houseEditViewController.delegate = self
		self.houseEditViewController.house = self.currentHouse!
		self.houseEditViewController.operation = operation
		
		self.presentViewControllerAsSheet(houseEditViewController)
	}
	
	/// Create the data operation on a person, the object to manipulate and open the sheet to perform the operation.
	fileprivate func performPersonDataAction(operation:DataOperation) {
		self.personEditViewController.delegate = self
		self.personEditViewController.person = self.currentPerson!
		self.personEditViewController.operation = operation
		
		self.presentViewControllerAsSheet(personEditViewController)
	}
    
}

// MARK: - HousePersonViewControllerDelegate

extension HouseViewController:HousePersonViewControllerDelegate {
	
	func handleUpdateHouse(isCanceled:Bool) {
		self.tableHouses.reloadData()
		
		if isCanceled &&  self.houseEditViewController.operation == DataOperation.Add {
			self.currentHouse = nil
		}
	}
	
	func handleUpdatePerson(isCanceled:Bool) {
		self.tablePersons.reloadData()
	}
}

// MARK: - NSTableViewDelegate, NSTableViewDataSource

extension HouseViewController: NSTableViewDelegate, NSTableViewDataSource {
	
	fileprivate enum CellIdentifiers {
		
		static let CellHouseSequence 		= "cellHouseSequence"
		static let CellHouseContact 		= "cellHouseContact"
		static let CellHouseAddress 		= "cellHouseAddress"
		static let CellHousePhone 			= "cellHousePhone"
		static let CellHouseDeliver 		= "cellHouseDeliver"
		static let CellHouseNotes 			= "cellHouseNotes"
		static let CellHouseRoute 			= "cellHouseRoute"
		static let CellHousePrinted 		= "cellHousePrinted"
		
		static let CellPersonNumber 		= "cellPersonNumber"
		static let CellPersonName 			= "cellPersonName"
		static let CellPersonAge 			= "cellPersonAge"
		static let CellPersonGender 		= "cellPersonGender"
		static let CellPersonHouseholdGift 	= "cellPersonHouseholdGift"
		static let CellPersonGiftIdeas 		= "cellPersonGiftIdeas"
		static let CellPersonOrganization 	= "cellPersonOrganization"

	}
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		
		if tableView == self.tableHouses {
			labelCountValue.stringValue = self.houseDao.list()!.count.toString()
			return self.houseDao.list()!.count
		} else {
			if self.currentHouse != nil {
				return self.personDao.list(house:self.currentHouse)!.count
			} else {
				return 0
			}
		}
	}

	func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {

		if row >= 0
		{
			if tableView == self.tableHouses {
				self.currentHouse = self.houseDao.list()![row]
				NSLog("selected house: " + self.currentHouse!.sequence.toString())
				
				self.currentPerson = nil
				self.tablePersons.reloadData()
				
				self.enableHouseControls(isEnabled: true)
				self.enablePersonControls(isAddEnabled:true, isUpdateDeleteEnabled: false)
				
			} else {
				self.currentPerson = self.personDao.list(house: self.currentHouse)?[row]
				NSLog("selected person: " + self.currentPerson!.sequence!)
				
				self.enablePersonControls(isAddEnabled: true, isUpdateDeleteEnabled: true)
			}
		}
		
		return true
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		
		var text: String = ""
		var cellIdentifier: String = ""
		
		if tableView == self.tableHouses {
			
			let house = self.houseDao.list()![row]
			
			//print(house)
			
			switch tableColumn! {
				 
			case tableView.tableColumns[0]:
				text = String(describing:house.sequence)
				cellIdentifier = CellIdentifiers.CellHouseSequence
			
			case tableView.tableColumns[1]:
				text = house.contact ?? ""
				cellIdentifier = CellIdentifiers.CellHouseContact
			
			case tableView.tableColumns[2]:
				text = house.address ?? ""
				cellIdentifier = CellIdentifiers.CellHouseAddress
			
			case tableView.tableColumns[3]:
				text = house.phone ?? ""
				cellIdentifier = CellIdentifiers.CellHousePhone

			case tableView.tableColumns[4]:
				text = house.deliver ? "YES" : "NO"
				cellIdentifier = CellIdentifiers.CellHouseDeliver

			case tableView.tableColumns[5]:
				text = house.notes ?? ""
				cellIdentifier = CellIdentifiers.CellHouseNotes

			case tableView.tableColumns[6]:
				text = (house.route?.routenumber) ?? ""
				cellIdentifier = CellIdentifiers.CellHouseRoute
			
			case tableView.tableColumns[7]:
				text = house.printed ? "YES" : "NO"
				cellIdentifier = CellIdentifiers.CellHousePrinted
			
			default:
				break
			
			}
			
		}
		else
		{
			let person = self.personDao.list(house:self.currentHouse)![row]
			
			switch tableColumn!
			{
			case tableView.tableColumns[0]:
				text = person.sequence ?? ""
				cellIdentifier = CellIdentifiers.CellPersonNumber
				
			case tableView.tableColumns[1]:
				text = person.name ?? ""
				cellIdentifier = CellIdentifiers.CellPersonName
				
			case tableView.tableColumns[2]:
				text = person.age ?? ""
				cellIdentifier = CellIdentifiers.CellPersonAge
				
			case tableView.tableColumns[3]:
				text = person.ismale ? "M" : "F"
				cellIdentifier = CellIdentifiers.CellPersonGender
				
			case tableView.tableColumns[4]:
				text = person.ishousegift ? "Y" : "N"
				cellIdentifier = CellIdentifiers.CellPersonHouseholdGift
				
			case tableView.tableColumns[5]:
				text = person.giftideas ?? ""
				cellIdentifier = CellIdentifiers.CellPersonGiftIdeas
				
			case tableView.tableColumns[6]:
				text = (person.organization?.name) ?? ""
				cellIdentifier = CellIdentifiers.CellPersonOrganization
				
			default:
				break
				
			}
			
		}
			
		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
		{
			cell.textField?.stringValue = text
			return cell
		}
		
		return nil
	}
	
}
