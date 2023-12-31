//
//  ViewController.swift
//  DI Part 2 - Pass Value
//
//  Created by Red Wang on 2023/10/25.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()

    var numberList: [String] = []
    
    
    // MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonPressed))
        setUpLayouts()
        setUpTableView()
    }
    private func setUpLayouts() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NumberCell.self, forCellReuseIdentifier: NumberCell.identifier)
        tableView.rowHeight = 50
    }
    
    // MARK: - Methods
    @objc func plusButtonPressed() {
        let inputVC = InputViewController()
        inputVC.delegate = self
        inputVC.action = .add
        
        inputVC.newNumberHandler = { newNumber in
            self.numberList.append(newNumber)
            self.tableView.reloadData()
        }
        
        navigationController?.pushViewController(inputVC, animated: false)
    }
    
 
    @objc func deleteButtonTapped(sender: UIButton) {
        // UITableViewCell hierarchy : subviews >>> contentView >>> UITableViewCell
        guard let cell = sender.superview?.superview as? NumberCell else { fatalError("Cannot find cell for button") }
        
        if let indexPath = tableView.indexPath(for: cell){
            numberList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
// MARK: - InputViewController Delegate
extension ViewController: InputViewControllerDelegate {
    
    func didChangeNumber(inputNumber: String, cellRow: Int) {
        numberList[cellRow] = inputNumber
        tableView.reloadData()
    }
    
    func didAddNumber(inputNumber: String) {
        numberList.append(inputNumber)
        tableView.reloadData()
    }
    
}
// MARK: - NumberCell Delegate
extension ViewController: NumberCellDelegate {
    
    func didPressDelete(_ cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            numberList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
// MARK: - Table View Data Source
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NumberCell.identifier, for: indexPath) as? NumberCell else {
            fatalError("Fail to create cell")
        }
        cell.configureCell(with: numberList[indexPath.row])
        cell.delegate = self
        
        // Delete: Target Action
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        // Delete: Closure
        cell.deleteHandler = {
            if let indexPath = tableView.indexPath(for: cell) {
                self.numberList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        return cell
    }
    
    
}

// MARK: - Table View Data Source and Delegate
extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? NumberCell else { return }
        
        let inputVC = InputViewController()
        inputVC.delegate = self
        inputVC.action = .change
        inputVC.numberTextField.text = cell.number
        inputVC.cellRowNumber = indexPath.row
        
        inputVC.newNumberHandler = { newNumber in
            self.numberList[indexPath.row] = newNumber
            self.tableView.reloadData()
        }
        
        navigationController?.pushViewController(inputVC, animated: false)
        
    }
    
}

    




