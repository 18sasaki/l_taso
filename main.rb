#coding: utf-8

# １反田Ａ、２反田Ｂ・・・と続けていくと、１０００反田Ｌになるらしい。
# 本当かどうか私、気になります！
# ということで「千反田える」の姉妹たちを表示していきます（１～９９９９９）。
# モードは３つ。
# normal：入力した数字をひらがな日本語読みで表示してくれるモード。
#         えるたそ関係なし！
#         "end"か"exit"で抜けるまで数字入力可能。
# select：入力した数字に対応した名前を表示してくれるモード。
#         "end"か"exit"で抜けるまで数字入力可能。
# roop  ：入力した数字まで、１反田Ａからひたすら表示するモード。
#         最後まで行くとモード選択画面に戻る。
# 隠しモード："selectx"、または"roopx"と入力すると、
#             各モードで名前表示時に「える」さんが「私、気になります！」と言います。
# 隠しモード："selectk"、または"roopk"と入力すると、
#             各モードで名前がひらがなで表示されます。
# "end"か"exit"で終了します。

Alp = ["えい",
       "びい",
       "しい",
       "でぃい",
       "いい",
       "えふ",
       "じい",
       "えっち",
       "あい",
       "じぇい",
       "けい",
       "える",
       "えむ",
       "えぬ",
       "おお",
       "ぴい",
       "きゅう",
       "あーる",
       "えす",
       "てぃい",
       "ゆう",
       "ぶい",
       "だぶりゅう",
       "えっくす",
       "わい",
       "ぜっと"]

Size = Alp.size

Numj = ["",
        "一",
        "二",
        "三",
        "四",
        "五",
        "六",
        "七",
        "八",
        "九"]

NumjKana = ["",
            "いち",
            "に",
            "さん",
            "よん",
            "ご",
            "ろく",
            "なな",
            "はち",
            "きゅう"]

Man = "まん"
Sen = {:n => "せん", :d => "ぜん"}
Hyaku = {:n => "ひゃく", :d => "びゃく"}
Juu = "じゅう"

def main(mode)
  while true do
    print "please input value > "
    case input_value = gets.chomp
    when "end", "exit"
      break
    when /^0+$/
      puts "!!!! Please input over zero !!!!"
      next
    when /^\d{1,5}$/
      num = input_value.to_i
      case mode
      when "normal"  then normal(num)
      when "normalk" then normal(num, true)
      when "select"  then self_select(num)
      when "selectx" then self_select(num, true)
      when "selectk" then self_select(num, true, true)
      when "roop"    then roop(num); break
      when "roopx"   then roop(num, true); break
      when "roopk"   then roop(num, true, true); break
      end
    else
      puts "!!!! Please input five or less digits. !!!!"
      next
    end
  end
end

def normal(num, kmode=false)
  if kmode
    str = trance_jap_kana(num).join(" ")
  else
    str = trance_jap(num).join(" ")
  end
  p str
end

def self_select(num, xmode=false, kmode=false)
  put_name(xmode, kmode, num)
end

def roop(num, xmode=false, kmode=false)
  num.times.each do |i|
    put_name(xmode, kmode, i+1)
  end
end

def put_name(xmode, kmode, target_num)
  str, alp_num = set_element(kmode, target_num)
  say = " ＜ 私、気になります！" if xmode && alp_num == 11
  p "#{str} #{Alp[alp_num]}#{say}"
end

def set_element(kmode, target_num)
  if kmode
    if target_num == 1000
      str = "ちたんだ"
    else
      str = trance_jap_kana(target_num).join("") + "たんだ"
    end
  else
    str = trance_jap(target_num).join("") + "反田"
  end
  alp_num = (target_num-1) % Size
  return str, alp_num
end

def trance_jap(target_num)
  target_hash = make_target_hash(target_num)
  str = []

  # 10000の位
  case target_hash[:m]
  when 0
  else
    str << Numj[target_hash[:m]] + "万"
  end

  simple_add(str, target_hash[:t], "千")
  simple_add(str, target_hash[:h], "百")
  simple_add(str, target_hash[:d], "十")

  # 1の位
  str << Numj[target_hash[:o]] if target_hash[:o] != 0

  return str
end

def simple_add(str, number, digit)
  case number
  when 0
  when 1
    str << digit
  else
    str << Numj[number] + digit
  end
end

def trance_jap_kana(target_num)
  target_hash = make_target_hash(target_num)
  str = []

  # 10000の位
  case target_hash[:m]
  when 0
  else
    str << NumjKana[target_hash[:m]] + Man
  end

  # 1000の位
  case target_hash[:t]
  when 0
  when 1
    str << Sen[:n]
  when 3
    str << NumjKana[target_hash[:t]] + Sen[:d]
  when 8
    str << "はっせん"
  else
    str << NumjKana[target_hash[:t]] + Sen[:n]
  end

  # 100の位
  case target_hash[:h]
  when 0
  when 1
    str << Hyaku[:n]
  when 3
    str << NumjKana[target_hash[:h]] + Hyaku[:d]
  when 6
    str << "ろっぴゃく"
  when 8
    str << "はっぴゃく"
  else
    str << NumjKana[target_hash[:h]] + Hyaku[:n]
  end

  # 10の位
  case target_hash[:d]
  when 0
  when 1
    str << Juu
  else
    str << NumjKana[target_hash[:d]] + Juu
  end

  # 1の位
  str << NumjKana[target_hash[:o]] if target_hash[:o] != 0

  return str
end

def make_target_hash(target_num)
  {:m => target_num/10000,
   :t => (target_num%10000)/1000,
   :h => (target_num%1000)/100,
   :d => (target_num%100)/10,
   :o => target_num%10}
end

while true do
  print "please select mode 'normal', 'select', 'roop'> "
  mode_value = gets.chomp
  case mode_value
  when "normal", "normalk", "select", "selectx", "selectk", "roop", "roopx", "roopk"
    main(mode_value)
  when "end", "exit"
    break
  else
    puts "!!!! '#{mode_value}' mode isn't exist !!!!"
    next
  end
end
