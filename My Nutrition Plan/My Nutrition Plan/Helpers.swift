//
//  Helpers.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 12/06/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import Foundation
import UIKit

struct Helpers{
	
	static func getDateTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}
