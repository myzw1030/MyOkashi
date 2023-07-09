//OkashiData.swift

import Foundation

// お菓子データ検索用クラス
class OkashiData: ObservableObject {
    // web API検索用メソッド　第一引数:keyword 検索したいワード
    func searchOkashi(keyword: String) {
        print("searchOkashiメソッドで受け取った値：\(keyword)")
        
        // Taskは非同期で処理を実行できる
        Task {
            await search(keyword: keyword)
        }
    }
    // 非同期でお菓子データを取得
    private func search(keyword: String) async {
        print("searchメソッドで受け取った値：\(keyword)")
    }
}
