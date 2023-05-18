//
//  MyTextView.swift
//  Note
//
//  Created by anca dev on 09/05/23.
//

import UIKit

class MyTextView: UITextView {

    override func caretRect(for Position: UITextPosition) -> CGRect {
        let superCaret = super.caretRect(for: Position)
        
        return CGRect(x: superCaret.origin.x, y: superCaret.origin.y - 1, width: superCaret.width, height: 20)
    }

}
