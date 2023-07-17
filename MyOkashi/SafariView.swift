//SafariView.swift

import SwiftUI
import SafariServices

// SFSafariViewControllerを起動する構造体
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    // 表示するViewを生成する時に実行
    func makeUIViewController(context: Context) -> SFSafariViewController {
        // Safariを起動
        return SFSafariViewController(url: url)
    }
    
    // Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
