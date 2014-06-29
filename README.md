
# これは何？

１反田Ａ、２反田Ｂ・・・と続けていくと、１０００反田Ｌ、つまり「千反田える」になるらしい。
本当かどうか私、気になります！
ということで千反田えるの姉妹たちを表示していきます（１～９９９９９）。

# 使い方
```
$ ruby main.rb
```

`please select mode 'normal', 'select', 'roop'> `
と出るので、以下のモードを選択

## モード

### normal
入力した数字を漢数字で表示してくれるモード。
えるたそ関係なし！
"end"か"exit"で抜けるまで数字入力可能。

### select
入力した数字に対応した名前を表示してくれるモード。
"end"か"exit"で抜けるまで数字入力可能。

### roop
入力した数字まで、１反田Ａからひたすら表示するモード。
最後まで行くとモード選択画面に戻る。

## 隠しモード

### "selectx"または"roopx"
各モードで名前表示時に「える」さんが「私、気になります！」と言います。

### "selectk"または"roopk"
各モードで名前がひらがなで表示されます。