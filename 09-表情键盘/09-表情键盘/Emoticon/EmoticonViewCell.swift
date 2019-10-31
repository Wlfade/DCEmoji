//
//  EmoticonViewCell.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/22.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    //MARK:- 懒加载属性
//    private lazy var emoticonBtn : UIButton = UIButton()
    private lazy var emoticonBtn : UIButton = {
        let emotionBtn = UIButton()
        return emotionBtn
    }()

    //MARK:- 定义属性
    var eomticon : Emoticon?{
        didSet {
            guard let emoticon = eomticon else {
                return
            }
            //设置emticonBtn的内容
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            
            emoticonBtn.setTitle(emoticon.emojiCode, for: .normal)
            
            if eomticon?.isRemove == true {
                   emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
               }
            
            if emoticon.isEmpty == true {
            }
        }
    }
    
    //MARK:- 重写构造函数
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EmoticonViewCell{
    private func setUpUI(){
        //1.添加子控件
        contentView.addSubview(emoticonBtn)
        //2.设置btn的frame
        emoticonBtn.frame = contentView.bounds
        //3.设置btn属性
        emoticonBtn.isUserInteractionEnabled = false
        
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
