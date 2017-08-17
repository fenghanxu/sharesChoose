import UIKit

protocol SPCellProtocol: class {
  static var id: String { get }
  static var nib: UINib? { get }
}

extension SPCellProtocol {
  static var id: String { return String(describing: Self.self) }
  static var nib: UINib? { return nil }
}

protocol SPNibProtocol: SPCellProtocol { }

extension SPNibProtocol {
  static var nib: UINib? { return UINib(nibName: String(describing: Self.self),
                                        bundle: nil) }
}

extension SPExtension where Base: UITableView{
  
  func register<T: UITableViewCell>(_ cell: T.Type) where T: SPCellProtocol {
    if let nib = T.nib {
      base.register(nib, forCellReuseIdentifier: T.id)
    } else {
      base.register(T.self, forCellReuseIdentifier: T.id)
    }
  }
  
  func dequeueCell<T: SPCellProtocol>(_ indexPath: IndexPath) -> T {
    return base.dequeueReusableCell(withIdentifier: T.id, for: indexPath) as! T
  }
  
  func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: SPCellProtocol {
    if let nib = T.nib {
      base.register(nib, forHeaderFooterViewReuseIdentifier: T.id)
    } else {
      base.register(T.self, forHeaderFooterViewReuseIdentifier: T.id)
    }
  }
  
  func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: SPCellProtocol {
    return base.dequeueReusableHeaderFooterView(withIdentifier: T.id) as! T
  }
}

extension SPExtension where Base: UICollectionView {
  
  func register<T: UICollectionViewCell>(_ cell: T.Type) where T: SPCellProtocol {
    if let nib = T.nib {
      base.register(nib, forCellWithReuseIdentifier: T.id)
    } else {
      base.register(T.self, forCellWithReuseIdentifier: T.id)
    }
  }
  
  func dequeueCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T where T: SPCellProtocol {
    return base.dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as! T
  }
  
  func registerSupplementaryView<T: SPCellProtocol>(elementKind: String, _: T.Type) {
    if let nib = T.nib {
      base.register(nib,
                    forSupplementaryViewOfKind: elementKind,
                    withReuseIdentifier: T.id)
    } else {
      base.register(T.self,
                    forSupplementaryViewOfKind: elementKind,
                    withReuseIdentifier: T.id)
    }
  }
  
  func dequeueSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: IndexPath) -> T where T: SPCellProtocol {
    return base.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                 withReuseIdentifier: T.id,
                                                 for: indexPath) as! T
  }
}
