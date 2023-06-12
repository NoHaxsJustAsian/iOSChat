//
//  ChatTableViewCell.swift
//  iOSChat
//
//  Created by Win Tongtawee on 6/11/23.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelText: UILabel!
    var labelTime: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        
        initConstraints()
    }

    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setuplabelText(){
        labelText = UILabel()
        labelText.font = UIFont.boldSystemFont(ofSize: 16)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func setupLabelTime(){
        labelTime = UILabel()
        labelTime.font = UIFont.boldSystemFont(ofSize: 12)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTime)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            
            labelText.topAnchor.constraint(equalTo: labelName.topAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelText.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            
            labelTime.topAnchor.constraint(equalTo: labelText.topAnchor, constant: 8),
            labelTime.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelTime.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            labelTime.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
            
            wrapperCellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 72)
        ])
        
        labelName.setContentCompressionResistancePriority(.required, for: .vertical)
        labelName.setContentHuggingPriority(.required, for: .vertical)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
