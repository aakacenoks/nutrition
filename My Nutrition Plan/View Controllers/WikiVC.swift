//
//  WikiVC.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 20/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit
import WebKit

class WikiVC: UIViewController {
	@IBOutlet weak var wikiView: WKWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let url = URL(string: "https://en.wikipedia.org/wiki/Food_pyramid_(nutrition)")
		let request = URLRequest(url: url!)
		wikiView.load(request)
    }
}
