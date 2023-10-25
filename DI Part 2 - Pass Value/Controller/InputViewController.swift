//
//  InputViewController.swift
//  DI Part 2 - Pass Value
//
//  Created by Red Wang on 2023/10/25.
//

import UIKit

enum UserAction {
    case change
    case add
}

protocol InputViewControllerDelegate: AnyObject {
    func didChangeNumber(inputNumber: String, cellRow: Int)
    func didAddNumber(inputNumber: String)

}

class InputViewController: UIViewController {
    
    var delegate: InputViewControllerDelegate?
    var newNumberHandler: ((String) -> Void)?
    var action: UserAction = .add
    var cellRowNumber: Int = 0
    
    // MARK: - Subviews
    let numberTextField: UITextField = {
        let numberTextField = UITextField()
        numberTextField.textColor = .black
        numberTextField.font = UIFont.systemFont(ofSize: 14)
        numberTextField.layer.borderColor = UIColor.darkGray.cgColor
        numberTextField.layer.borderWidth = 1.0
        numberTextField.layer.cornerRadius = 5.0
        return numberTextField
    }()
    
    let enterButton: UIButton = {
        let enterButton = UIButton()
        enterButton.setTitle("Enter", for: .normal)
        enterButton.backgroundColor = .black
        enterButton.layer.cornerRadius = 5.0
        return enterButton
    }()
    
    // MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUpLayouts()
        setUpActions()
        
    }
    private func setUpLayouts() {
        view.addSubview(numberTextField)
        view.addSubview(enterButton)
        
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            numberTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            numberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            numberTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2.0 / 3.0),
            
            enterButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 40),
            enterButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2.0 / 3.0)
        ])
    }
    private func setUpActions() {
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Methods
    @objc func enterButtonPressed() {
        guard let inputNumber = numberTextField.text,
              inputNumber != "" else { return }
        
        newNumberHandler?(inputNumber)
        
        if action == .add {
           // delegate?.didAddNumber(inputNumber: inputNumber)
        } else {
           // delegate?.didChangeNumber(inputNumber: inputNumber, cellRow: cellRowNumber)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
