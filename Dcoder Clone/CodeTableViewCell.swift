//
//  CodeTableViewCell.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import UIKit

class CodeTableViewCell: UITableViewCell {
    
    static let cellID = "CodeTableViewCell"

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var username: UILabel!
//    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!
    @IBOutlet weak var upvoteButton: UIButton!
    
    var stackView = UIStackView()
    
    var code: Code?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.setShadow()
        mainView.setCornerRadius(to: 12)
        profileImage.setCornerRadius(to: 17)
        profileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(code: Code) {
        self.code = code
        subject.text = code.title
        username.text = code.userName
        timeAgo.text = code.time?.getDateFromTimeInterval()
        let upvotes = "\(code.upvotes ?? 0)"
        let downvotes = "\(code.downvotes ?? 0)"
        let comments = "\(code.comments ?? 0)"
        self.upvoteButton.setTitle(upvotes, for: .normal)
        self.downvoteButton.setTitle(downvotes, for: .normal)
        self.commentsButton.setTitle(comments, for: .normal)
        self.configureStackView()
        
    }
    
    func configureStackView() {
        stackView.removeFromSuperview()
        stackView = UIStackView()
        mainView.addSubview(stackView)
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.profileImage.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: upvoteButton.leadingAnchor, constant: -16).isActive = true
            stackView.centerYAnchor.constraint(equalTo: upvoteButton.centerYAnchor).isActive = true
        var tagCount = code?.tags?.count ?? 0
        tagCount = tagCount > 3 ? 3 : tagCount
        for tag in 0...2 {
            let label = UILabel()
            label.text = code?.tags?[tag]
            label.backgroundColor = .systemTeal
            label.textColor = .white
            label.font = .systemFont(ofSize: 12)
            label.textAlignment = .center
            label.setCornerRadius(to: 2)
            stackView.addArrangedSubview(label)
        }
        
        
    }
    

}
