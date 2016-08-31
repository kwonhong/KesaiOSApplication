//
//  ContactCell.swift
//  KesaApplication
//
//  Created by Jiwoo Lim on 2016. 7. 19..
//  Copyright © 2016년 kesa. All rights reserved.
//

import UIKit

class ContactCell : UITableViewCell {
    
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func layoutSubviews() {
        //making the a round image frame
        thumbnail.layer.cornerRadius = thumbnail.bounds.height/2
        thumbnail.clipsToBounds = true
        //white border
        self.thumbnail.layer.borderWidth = 2
        self.thumbnail.layer.borderColor = UIColor.orangeColor().CGColor
    }
    
    
    @IBOutlet weak var name: UILabel!
   
    
    @IBOutlet weak var department: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
}
