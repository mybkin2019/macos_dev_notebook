//
//  CustomWebView.swift
//  MacosDevNotebook
//
//  Created by mabs on 01/12/2022.
//

import Cocoa
import WebKit

class CustomWebViewViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    // 解决url string中含有中文 无法解析 url的问题
    // let url = URL(string: "https://voice.baidu.com/act/newpneumonia/newpneumonia/?from=osari_aladin_banner&city=广东-佛山".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let url = URL(string: "https://voice.baidu.com/act/newpneumonia/newpneumonia/?from=osari_aladin_banner&city=广东-佛山".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        guard let url = url else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5.0)
        webView.load(request)
    }
}
