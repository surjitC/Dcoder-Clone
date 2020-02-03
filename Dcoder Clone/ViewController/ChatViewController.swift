//
//  ChatViewController.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    
    var chatMessages: [Chat] = []
    var chatViewModel = ChatViewModel()
    
    let inputContentView = UIView()
    let sendButton = UIButton()
    let inputTextView = UITextView()
    var inputViewBottom: NSLayoutConstraint!
    var trailing: CGFloat = 0
    
     override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            self.title = "Chat"
            self.view.backgroundColor = .systemTeal
            self.chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.cellID)
            self.chatTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 60, right: 0)
            self.setInputView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            trailing = inputViewBottom.constant
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
            inputViewBottom.constant = -(keyboardHeight - tabBarHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            inputViewBottom.constant = trailing
            self.view.layoutIfNeeded()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chatViewModel.getChatMessage { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    self?.chatTableView.reloadData()
                }
            }
            
        }
        
    }
        
        func setInputView() {
            
            self.view.addSubview(inputContentView)
            inputContentView.backgroundColor = .white
            inputContentView.translatesAutoresizingMaskIntoConstraints = false
            inputContentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            inputContentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            inputViewBottom = inputContentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            inputViewBottom.isActive = true
            inputContentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            
            
            sendButton.setBackgroundImage(UIImage(named: "send"), for: .normal)
            inputContentView.addSubview(sendButton)
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            sendButton.trailingAnchor.constraint(equalTo: inputContentView.trailingAnchor, constant: -8).isActive = true
            sendButton.topAnchor.constraint(equalTo: inputContentView.topAnchor, constant: 16).isActive = true
            sendButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
            sendButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            sendButton.addTarget(self, action: #selector(sendButtonTapped(_:)), for: .touchUpInside)
            
            
            inputContentView.addSubview(inputTextView)
            
            inputTextView.translatesAutoresizingMaskIntoConstraints = false
            
            inputTextView.font = .systemFont(ofSize: 16)
            inputTextView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.6).cgColor
            inputTextView.layer.borderWidth = 2
            inputTextView.layer.cornerRadius = 22
            inputTextView.clipsToBounds = true
            
            inputTextView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8).isActive = true
            inputTextView.leadingAnchor.constraint(equalTo: inputContentView.leadingAnchor, constant: 8).isActive = true
            inputTextView.bottomAnchor.constraint(equalTo: inputContentView.bottomAnchor, constant: -8).isActive = true
            inputTextView.topAnchor.constraint(equalTo: inputContentView.topAnchor, constant: 8).isActive = true
            inputTextView.contentInset = UIEdgeInsets(top: 4, left: 20, bottom: 2, right: 20)
            
        }
    
    @objc func sendButtonTapped(_ sender: UIButton) {
        inputTextView.endEditing(true)
        guard let message = inputTextView.text, !message.isEmpty else { return }
        chatViewModel.set(message: message)
        chatTableView.reloadData()
        inputTextView.text = ""
    }

    }

    extension ChatViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return chatViewModel.chatMessages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.cellID, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
            let chatMessage = chatViewModel.chatMessages[indexPath.row]
            cell.chatMessage = chatMessage
            cell.profileImageView.image = nil //or keep any placeholder here
            cell.tag = indexPath.row
            if let imageURL = chatMessage.userImageURL {
                ServiceHandler.sharedInstance.downloadImage(imageURL: imageURL) { (data) in
                    guard let data = data else { return }

                    DispatchQueue.main.async() {
                        if cell.tag == indexPath.row{
                            cell.profileImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            return cell
        }
        
        
    }

extension ChatViewController: UITextViewDelegate {
    
}

