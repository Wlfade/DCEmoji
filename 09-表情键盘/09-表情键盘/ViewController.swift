//
//  ViewController.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/22.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- 控件属性
    @IBOutlet weak var textView: UITextView!
    
    private lazy var emoticonVC : EmoticaonController = EmoticaonController { [weak self](emoticon) in
        self?.inserEmoticonIntoTextView(emoticon: emoticon)
    }
    
    private func inserEmoticonIntoTextView(emoticon : Emoticon){
        print(emoticon)
        self.textView.insertEmoticon(emoticon: emoticon)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputView = emoticonVC.view
        
        let manager = EmoticonManager()
        for package in manager.packages {
            for emoticon in package.emoticons {
                print(emoticon)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    @IBAction func sendAction(_ sender: Any) {
        print(textView.getEmoticonString())
    }
}

