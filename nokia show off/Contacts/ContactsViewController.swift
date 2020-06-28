//
//  ContactsViewController.swift
//  nokia show off
//
//  Created by Alfredo Uzumaki on 6/28/20.
//  Copyright © 2020 Alfredo Uzumaki. All rights reserved.
//

import UIKit

class ContactsViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var contacts = PhoneContacts.getContacts()
    var selectedIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContactPage()
    }
    
    func setupContactPage() {
        antenaImageView.isHidden = true
        centerNokiaLabel.isHidden = true
        batteryImageViews.forEach({$0.isHidden = true})
        setupTableView()
    }
    
    func setupTableView() {
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.allowsSelection = true
        tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .top)
    }
    
    override func endCallButtonAction() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        switchControllerTo(vc)
    }
}

// MARK: TableView Functions
extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.font = centerNokiaLabel.font.withSize(34)
        cell.textLabel?.text = contact.getName()
        cell.textLabel?.textColor = indexPath.row == selectedIndex ? #colorLiteral(red: 0.630094409, green: 0.8224702477, blue: 0.3559359312, alpha: 1) : .black
        cell.setSelected(indexPath.row == selectedIndex, animated: true)
        cell.backgroundColor = indexPath.row == selectedIndex ? .black : .clear
        return cell
    }
}
