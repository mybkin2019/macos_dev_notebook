//
//  SandboxNetworkConnectionVC.swift
//  MacosDevNotebook
//
//  Created by mabs on 30/11/2022.
//

import Cocoa

class SandboxNetworkConnectionVC: NSViewController {
    
    // info plist 文件里添加
    // Outgoing Network Connections => YES
    @IBAction func sendRequestBtnAction(_ sender: Any) {
        let headers = [
            "X-RapidAPI-Key": "f29c9fdca9msh151ad442cffaea1p15a8c5jsn1e1e3dc38279",
            "X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://covid-19-statistics.p.rapidapi.com/reports/total?date=2022-11-29")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
