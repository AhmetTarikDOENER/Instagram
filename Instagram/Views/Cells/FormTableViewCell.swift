//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 1.11.2023.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        
        return field
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubviews(formLabel, textField)
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FormTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
