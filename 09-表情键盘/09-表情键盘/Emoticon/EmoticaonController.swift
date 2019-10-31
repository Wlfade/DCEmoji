//
//  EmoticaonController.swift
//  09-表情键盘
//
//  Created by 单车 on 2019/10/22.
//  Copyright © 2019 单车. All rights reserved.
//

import UIKit

private let EmoticonCell = "EmoticonCell"

class EmoticaonController: UIViewController {
    //MARK:- 定义属性
    var emoticonCallBack : (_ emotiocon : Emoticon) -> ()
    

    //MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmoticonCollectionViewLayout())
    private lazy var toolBar : UIToolbar = UIToolbar()
    private lazy var manager = EmoticonManager()
    
    //MARK:- 自定义构造函数
    init(emoticonCallBack:@escaping (_ emotiocon : Emoticon)->()) {
//        super.init(nibName)
        self.emoticonCallBack = emoticonCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(code:) has not")
    }
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK:- 设置UI界面内容
extension EmoticaonController{
    private func setupUI(){
        //1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = .purple
        toolBar.backgroundColor = .red
        
        //2.设置子控件的frame
        //vfl 代码约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar":toolBar,"cView":collectionView]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cView]-0-[tBar]-0-|", options: [.alignAllLeft,.alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        prepareForCollectionView()
        
        prepareForToolBar()
    }
    
    private func prepareForCollectionView(){
        //1.注册cell和设置数据源
        collectionView.register(EmoticonViewCell.self, forCellWithReuseIdentifier: EmoticonCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func prepareForToolBar(){
        //1.定义toolBar中的titles
        let titles = ["最近","默认","emoji","浪小花"]
        
        //2.遍历标题，创建item
        var index = 0
        var tempItems = [UIBarButtonItem]()
        
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(_:)))
            
            item.tag = index
            
            index += 1
            
            tempItems.append(item)
            
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        //3.设置toolBar的items数组
        tempItems.removeLast()
        
        toolBar.items = tempItems
        
        toolBar.tintColor = UIColor.orange
    }
    @objc private func itemClick(_ item : UIBarButtonItem){
        //1.获取点击的item的tag
        let tag = item.tag
        
        //2.根据tag获取到当前组
        let indexPath = NSIndexPath(item: 0, section: tag)
        
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
    
}
//MARK:- collectionView的数据源和代理方法
extension EmoticaonController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = manager.packages[section]
        
        return package.emoticons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCell, for: indexPath) as! EmoticonViewCell
        
        //2.设置数据
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        cell.eomticon = emoticon
        return cell
        
    }
    
    //代理方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出点击的表情
        let package = manager.packages[indexPath.section]
        let emoticon = package.emoticons[indexPath.item]
        
        //2.将点击的表情插入到最近分组中
        insertRecentlyEmoticon(emoticon: emoticon)
        
        //3.将表情回调给外界控制器
        emoticonCallBack(emoticon)
    }
    
    private func insertRecentlyEmoticon(emoticon:Emoticon){
        //1.如果是空白表情或者删除按钮，不需要插入
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        
        //2.删除一个表情
        if (manager.packages.first?.emoticons.contains(emoticon) == true) {
            //原来有该表情
            let index = (manager.packages.first?.emoticons.firstIndex(of: emoticon))!
            manager.packages.first?.emoticons.remove(at: index)
        }else{
            manager.packages.first?.emoticons.remove(at: 19)
        }
        
        //2.将emoticon 插入到最近分组中
        manager.packages.first?.emoticons.insert(emoticon, at: 0)
    }
}

class EmoticonCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare(){
        super.prepare()
        
        //1.计算itemWH
        let itemWH = UIScreen.main.bounds.width / 7
        
        //2.设置layout的属性
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0;
        minimumInteritemSpacing = 0;
        
        scrollDirection = .horizontal
        
        //3.设置collectionView的属性
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        let insetMargin = (collectionView!.bounds.height - 3*itemWH)/2
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
        
    }
}
