//ContentView.swift

import SwiftUI

struct ContentView: View {
    
    // OkashiDataを参照する状態変数
    @StateObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    // SafariViewの表示有無を管理する変数
    @State var showSafari = false
    
    var body: some View {
        VStack {
            TextField("キーワード",
            text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit {
                // 入力完了直後に検索をする
                okashiDataList.searchOkashi(keyword: inputText)
            }
            .submitLabel(.search)
            .padding()
            
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                Button {
                    // 選択したリンクを保存
                    okashiDataList.okashiLink = okashi.link
                    showSafari.toggle()
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
            .sheet(isPresented: $showSafari, content: {
                SafariView(url: okashiDataList.okashiLink!)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
