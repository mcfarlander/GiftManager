//
//  HouseViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/10/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class HouseViewController: NSViewController
{
	var managedContext = (NSApplication.shared.delegate as! AppDelegate).managedObjectContext

	@IBOutlet var labelCount: NSTextField!
	@IBOutlet var labelCountValue: NSTextField!
	
	@IBOutlet var tableHouses: NSTableView!
	@IBOutlet var tablePersons: NSTableView!
	
	@IBOutlet weak var btnAddHouse: NSButton!
    @IBOutlet weak var btnUpdateHouse: NSButton!
    @IBOutlet weak var btnDeleteHouse: NSButton!
	
    @IBOutlet weak var btnAddPerson: NSButton!
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
	
    override func viewDidLoad()
    {
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
    
    @IBAction func btnAddHouse_Action(_ sender: NSButton)
    {
        NSLog("add house action")
		self.currentHouse = self.houseDao.create(contact: "", phone: "")
		self.performHouseDataAction(operation: .Add)
    }
    
    @IBAction func btnUpdateHouse_Action(_ sender: NSButton)
    {
        NSLog("update house action")
		self.performHouseDataAction(operation: .Update)
    }

    @IBAction func btnDeleteHouse_Action(_ sender: NSButton)
    {
        NSLog("delete house action")
		self.performHouseDataAction(operation: .Delete)
    }
    
    @IBAction func btnAddPerson_Action(_ sender: NSButton)
    {
        NSLog("add person action")
		
		self.performPersonDataAction(operation: .Add)
    }
    
    @IBAction func btnUpdatePerson_Action(_ sender: NSButton)
    {
        NSLog("update person action")
        self.performPersonDataAction(operation: .Update)
    }
    
    @IBAction func btnDeletePerson_Action(_ sender: NSButton)
    {
        NSLog("delete person action")
        self.performPersonDataAction(operation: .Delete)
    }
	
	fileprivate func enableHouseControls(isEnabled:Bool)
	{
		self.btnUpdateHouse.isEnabled = isEnabled
		self.btnDeleteHouse.isEnabled = isEnabled
	}
	
	fileprivate func enablePersonControls(isAddEnabled:Bool, isUpdateDeleteEnabled:Bool)
	{
		self.btnAddPerson.isEnabled = isAddEnabled
		self.btnUpdatePerson.isEnabled = isUpdateDeleteEnabled
		self.btnDeletePerson.isEnabled = isUpdateDeleteEnabled
	}
	
	fileprivate func performHouseDataAction(operation:DataOperation)
	{
		self.houseEditViewController.delegate = self
		self.houseEditViewController.house = self.currentHouse!
		self.houseEditViewController.operation = operation
		
		self.presentViewControllerAsSheet(houseEditViewController)
	}
	
	fileprivate func performPersonDataAction(operation:DataOperation)
	{
		self.personEditViewController.delegate = self
		self.personEditViewController.person = self.currentPerson!
		self.personEditViewController.operation = operation
		
		self.presentViewControllerAsSheet(personEditViewController)
	}
    
}

extension HouseViewController:HousePersonViewControllerDelegate
{
	func handleUpdateHouse()
	{
		self.tableHouses.reloadData()
	}
	
	func handleUpdatePerson()
	{
		self.tablePersons.reloadData()
	}
}

extension HouseViewController: NSTableViewDelegate, NSTableViewDataSource
{
	fileprivate enum CellIdentifiers
	{
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
	
	func numberOfRows(in tableView: NSTableView) -> Int
	{
		if tableView == self.tableHouses
		{
			labelCountValue.stringValue = self.houseDao.list()!.count.toString()
			return self.houseDao.list()!.count
		}
		else
		{
			if self.currentHouse != nil
			{
				return self.personDao.list(house:self.currentHouse)!.count
			}
			else
			{
				return 0
			}
		}
	}

	func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool
	{

		if row >= 0
		{
			if tableView == self.tableHouses
			{
				self.currentHouse = self.houseDao.list()![row]
				self.currentPerson = nil
				self.tablePersons.reloadData()
				
				self.enableHouseControls(isEnabled: true)
				self.enablePersonControls(isAddEnabled:true, isUpdateDeleteEnabled: false)
				
			}
			else
			{
				self.currentPerson = self.personDao.list(house: self.currentHouse)?[row]
				self.enablePersonControls(isAddEnabled: true, isUpdateDeleteEnabled: true)
			}
		}
		
		return true
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
	{
		var text: String = ""
		var cellIdentifier: String = ""
		
		if tableView == self.tableHouses
		{
			let house = self.houseDao.list()![row]
			
			//print(house)
			
			switch tableColumn!
			{
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
