//
//  testTableVIew.swift
//  KesaApplication
//
//  Created by Jeff on 2016. 6. 16..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit

class testTableVIew: UITableView, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
        
    override func numberOfRowsInSection(section: Int) -> Int {
        return 3;
    }
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        let cell = self.dequeueReusableCellWithIdentifier("testTableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    

}
