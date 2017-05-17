module BookDetailsHelper


  def sale_for(first_digit)
    case first_digit
    when "0" then
      "一般"
    when "1" then
      "教養"
    when "2" then
      "実用"
    when "3" then
      "専門"
    when "5" then
      "婦人"
    when "6" then
      "学参I(小中)"
    when "7" then
      "学参II(高校)"
    when "8" then
      "児童"
    when "9" then
      "雑誌扱い"
    else
      "不明/なし"
    end
  end
  
  def published_in(second_digit)
    case second_digit
    when "0" then
      "単行本"
    when "1" then
      "文庫"
    when "2" then
      "新書"
    when "3" then
      "全集・双書"
    when "4" then
      "ムック・その他"
    when "5" then
      "事・辞典"
    when "6" then
      "図鑑"
    when "7" then
      "絵本"
    when "8" then
      "磁性媒体など"
    when "9" then
      "コミック"
    else
      "不明/なし"
    end
  end
  
  def content_for(last_two_digits)
    case last_two_digits
    when "00" then
      "総記"
    when "01" then
      "百科事典"
    when "02" then
      "年鑑・雑誌"
    when "04" then
      "情報科学"
    when "10" then
      "哲学"
    when "11" then
      "心理(学)"
    when "12" then
      "倫理(学)"
    when "14" then
      "宗教"
    when "15" then
      "仏教"
    when "16" then
      "キリスト教"
    when "20" then
      "歴史総記"
    when "21" then
      "日本歴史"
    when "22"	then
      "外国歴史"
    when "23" then
      "伝記"
    when "25" then
      "地理"
    when "26" then
      "旅行"
    when "30" then
      "社会科学総記"
    when "31" then
      "政治-含む国防軍事"
    when "32" then
      "法律"
    when "33" then
      "経済・財政・統計"
    when "34" then
      "経営"
    when "36" then
      "社会"
    when "37" then
      "教育"
    when "39" then
      "民族・風習"
    when "40" then
      "自然科学総記"
    when "41" then
      "数学"
    when "42" then
      "物理学"
    when "43" then
      "化学"
    when "44" then
      "天文・地学"
    when "45" then
      "生物学"
    when "47" then
      "医学・歯学・薬学"
    when "50" then
      "工学・工学総記"
    when "51" then
      "土木"
    when "52" then
      "建築"
    when "53" then
      "機械"
    when "54" then
      "電気"
    when "55" then
      "電子通信"
    when "56" then
      "海事"
    when "57" then
      "採鉱・冶金"
    when "58" then
      "その他の工業"
    when "60" then
      "産業総記"
    when "61" then
      "農林業"
    when "62" then
      "水産業"
    when "63" then
      "商業"
    when "65" then
      "交通・通信"
    when "70" then
      "芸術総記"
    when "71" then
      "絵画・彫刻"
    when "72" then
      "写真・工芸"
    when "73" then
      "音楽・舞踊"
    when "74" then
      "演劇・映画"
    when "75" then
      "体育・スポーツ"
    when "76" then
      "諸芸・娯楽"
    when "77" then
      "家事"
    when "79" then
      "コミックス・劇画"
    when "80" then
      "語学総記"
    when "81" then
      "日本語"
    when "82" then
      "英米語"
    when "84" then
      "ドイツ語"
    when "85" then
      "フランス語"
    when "87" then
      "各国語"
    when "90" then
      "文学総記"
    when "91" then
      "日本文学総記"
    when "92" then
      "日本文学詩歌"
    when "93" then
      "日本文学、小説・物語"
    when "95" then
      "日本文学、評論、随筆、その他"
    when "97" then
      "外国文学小説"
    when "98" then
      "外国文学、その他"
    else
      "不明/なし"
    end
  end
    
  def books_count(book_details)
    books = []
    book_details.each do |book_detail|
      books += book_detail.books
    end
    books.count
  end
  
end
