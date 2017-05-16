BookDetail.seed(:id) do |s|
    s.id = 1
    s.isbn_code = "978-4-83995-064-4"
    s.c_code = "C3055"
    s.title = "よくわかるPHPの許可書 PHP5.5対応版"
    s.writer = "たにぐちまこと"
    s.publisher = "マイナビ"
    s.content = "ノンプログラマでも安心。最強の入門書!"
end
puts "書籍情報ID-1を登録しました。"
BookDetail.seed(:id) do |s|
    s.id = 2,
    s.isbn_code = "978-4-88433-723-2"
    s.c_code = "C3055"
    s.title = "Rails4技術者認定シルバー試験問題集"
    s.writer = "株式会社システムシェアード 山田裕進"
    s.publisher = "インプレス"
    s.content = "注目のRuby on Rails資格、唯一の公式問題集登場!これ一冊で全てOK!模擬問題2回分付き!"
end
puts "書籍情報ID-2を登録しました。"


