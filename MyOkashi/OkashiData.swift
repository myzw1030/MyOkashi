//OkashiData.swift

import Foundation

// Identifiableプロトコルを利用して、お菓子の情報をまとめる構造体
struct OkashiItem: Identifiable {
    let id = UUID()
    let name: String
    let link: URL
    let image: URL
}

// お菓子データ検索用クラス
class OkashiData: ObservableObject {
    // JSONデータ構造
    struct ResultJson: Codable {
        struct Item: Codable {
            // お菓子の名称
            let name: String?
            // 掲載URL
            let url: URL?
            // 画像URL
            let image: URL?
        }
        // 複数要素
        let item: [Item]?
    }
    
    // お菓子のリスト（Identifibleプロトコル）
    @Published var okashiList: [OkashiItem] = []
    
    // web API検索用メソッド　第一引数:keyword 検索したいワード
    func searchOkashi(keyword: String) {

        
        // Taskは非同期で処理を実行できる
        Task {
            await search(keyword: keyword)
        }
    }
    // 非同期でお菓子データを取得
    private func search(keyword: String) async {
        // お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        
        // リクエストエリアの組み立て
        guard let req_url = URL(string:
                                    "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print(req_url)
        
        do {
            // リクエストURLからダウンロード
            let (data , _) = try await URLSession.shared.data(from: req_url)
            // JSONDecoderのインスタンス取得
            let decoder = JSONDecoder()
            // 受け取ったJSONデータをパース（解析）して格納
            let json = try decoder.decode(ResultJson.self, from: data)
            
            print(json)
        } catch {
            print("エラーが出た！")
        }
    }
}
