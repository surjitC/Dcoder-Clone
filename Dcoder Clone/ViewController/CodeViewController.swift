//
//  ViewController.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {

    @IBOutlet weak var codeTableView: UITableView!
    
    let codeViewModel = CodeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Dcoder"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        codeViewModel.getCodeData { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    self?.codeTableView.reloadData()
                }
            }
            
        }
        
    }


}

extension CodeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.codeViewModel.codeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CodeTableViewCell.cellID, for: indexPath) as? CodeTableViewCell else { return UITableViewCell() }
        let code = self.codeViewModel.codeData[indexPath.row]
        cell.configureCell(code: code)
        cell.profileImage.image = nil //or keep any placeholder here
        cell.tag = indexPath.row
        if let imageURL = code.userImageURL {
            ServiceHandler.sharedInstance.downloadImage(imageURL: imageURL) { (data) in
                guard let data = data else { return }

                DispatchQueue.main.async() {
                    if cell.tag == indexPath.row{
                        cell.profileImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
    
    
}

