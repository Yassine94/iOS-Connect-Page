//
//  TetrisView.swift
//  Project
//
//  Created by Yassine FATIHI / Maxime GOUENARD on 14/02/2019.
//  Copyright © 2019 Yassine FATIHI / Maxime GOUENARD All rights reserved.
//

import UIKit

class TetrisView: UIView {

    // IBOulet
    @IBOutlet var contentView: UIView!
    
    // Delegate
    var delegate: TetrisViewDelegate?
    
    // Méthodes Initialisation
    override init(frame: CGRect){
        super.init(frame: frame)
        commontInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commontInit()
    }
    private func commontInit(){
        Bundle.main.loadNibNamed("TetrisView", owner: self, options:nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    //Méthode Action
    @IBAction func buttonReturn() {
        delegate?.backToProfile()
    }
}
