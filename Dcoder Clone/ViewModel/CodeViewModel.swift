//
//  CodeViewModel.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import Foundation

class CodeViewModel {
    
    var codeData: [Code] = []
    
    func getCodeData(completionHandler: @escaping ((Bool) -> Void)) {
        let service = ServiceHandler.sharedInstance
        let endpoint = "https://dcoder.tech/test_json/codes.json"
        service.getAPIData(URLString: endpoint, objectType: [Code].self) { [weak self] (result: CustomResult) in
            switch result {
            case .success(let object):
                self?.codeData = object
                completionHandler(true)
            case .failure:
                completionHandler(false)
            }
        }
    }
    
    func getCodeData() -> [Code] {
        return self.codeData
    }
}
