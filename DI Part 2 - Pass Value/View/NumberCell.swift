//
//  NumberCell.swift
//  DI Part 2 - Pass Value
//
//  Created by Red Wang on 2023/10/25.
//

import UIKit

protocol NumberCellDelegate {
    func didPressDelete(_ cell: UITableViewCell)
}

class NumberCell: UITableViewCell {
    
    static let identifier = "\(NumberCell.self)"
   
    var number: String = ""
    var deleteHandler: (() -> Void)?
    var delegate: NumberCellDelegate?
 
    // MARK: - Subviews
    private let numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.font = UIFont.systemFont(ofSize: 16)
        numberLabel.textColor = .black
        numberLabel.textAlignment = .left
        return numberLabel
    }()
   let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.layer.borderColor = UIColor.red.cgColor
        deleteButton.layer.borderWidth = 1.0
        deleteButton.backgroundColor = .white
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.layer.cornerRadius = 5.0
        deleteButton.titleLabel?.font = deleteButton.titleLabel?.font.withSize(12)
       return deleteButton
    }()
    
    // MARK: - View Load
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpLayouts()
        setUpAction()
    }
    private func setUpLayouts() {
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(deleteButton)
        
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            deleteButton.heightAnchor.constraint(equalToConstant: 25),
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
           deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    private func setUpAction() {
        
        //deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    // MARK: - Methods
    @objc func deleteTapped(_ sender: UIButton) {
        
        deleteHandler?()
        
        //delegate?.didPressDelete(self)
    }
    
    func configureCell(with number: String) {
        self.number = number
        numberLabel.text = "\(number)"
    }
    
}
