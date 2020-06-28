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
    @IBOutlet weak var topArrowButton: UIButton!
    @IBAction func topArrowButtonTouchDownAction(_ sender: Any) {
        startAutoMoveUp()
    }
    @IBAction func topArrowButtonTouchUpAction(_ sender: Any) {
        stopAutoMoveUp()
    }
    @IBOutlet weak var bottomArrowButton: UIButton!
    @IBAction func bottomArrowButtonTouchDownAction(_ sender: Any) {
        startAutoMoveDown()
    }
    @IBAction func bottomArrowButtonTouchUpAction(_ sender: Any) {
        stopAutoMoveDown()
    }
    
    var selectedIndex = 2
    var autoMoveDownTimer:Timer?
    var autoMoveUpTimer:Timer?
    lazy var contacts = PhoneContacts.getContacts()

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
}

// MARK: - Action Functions
extension ContactsViewController {
    
    override func endCallButtonAction() {
        beep()
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        switchControllerTo(vc)
    }
    
    override func callButtonAction() {
        beep()
        callNumber(contacts[selectedIndex].getPhone())
    }
    
    override func dial(number: Int) {
        beep()
    }
    
    func moveToTopContact() {
        beep()
        if selectedIndex > 0 {
            selectedIndex -= 1
            tableView.reloadData()
            let firstRowIndex = tableView.indexPathsForVisibleRows!.first!.row
            if firstRowIndex >= selectedIndex-1  {
                tableView.scrollToRow(at: IndexPath(row: selectedIndex < 1 ? 0 : selectedIndex-1, section: 0), at: .top, animated: false)
            }
        }
    }
    
    @objc func moveToBottomContact() {
        beep()
        if selectedIndex < contacts.count-1 {
            selectedIndex += 1
            tableView.reloadData()
            let lastRowIndex = tableView.indexPathsForVisibleRows!.last!.row
            if lastRowIndex <= selectedIndex+1  {
                tableView.scrollToRow(at: IndexPath(row: selectedIndex+1, section: 0), at: .bottom, animated: false)
            }
        }
    }
    
    func startAutoMoveDown() {
        autoMoveDownTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(moveToBottomContact), userInfo: nil, repeats: true)
        autoMoveDownTimer?.fire()
    }
    
    func stopAutoMoveDown() {
        autoMoveDownTimer?.invalidate()
        autoMoveDownTimer = nil
    }
    
    func startAutoMoveUp() {
        autoMoveUpTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { (timer) in
            self.moveToTopContact()
        })
        autoMoveUpTimer?.fire()
    }
    
    func stopAutoMoveUp() {
        autoMoveUpTimer?.invalidate()
        autoMoveUpTimer = nil
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
        let name = contact.getName()
        if name.isContainsLetters() {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = contact.getPhone()
        }
        cell.textLabel?.textColor = indexPath.row == selectedIndex ? #colorLiteral(red: 0.630094409, green: 0.8224702477, blue: 0.3559359312, alpha: 1) : .black
        cell.setSelected(indexPath.row == selectedIndex, animated: true)
        cell.backgroundColor = indexPath.row == selectedIndex ? .black : .clear
        return cell
    }
}
