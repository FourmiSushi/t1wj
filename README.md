# traP1weekjissou 第2回　AI関係の何か

アクションゲームのAIを記述するための便利クラス群を作ろうとしたらあまりうまくいかなかった

## 考えたこと

アクションゲーム（主にプラットフォーマー）のAIは大抵の場合、決まった動きをし続けるものや一定のパターンで動くものが多く、簡単な条件分岐などで書くことができる。
と思っていたが、状態の管理や行動の終了などを考えると思っていたより面倒事が多いので、それらをうまく扱える仕組みが必要だと考えた。

少し前にパーサーコンビネーターを作ったため、そのようなスタイル（ちょっとDSLのようにも感じる）でAIを記述できると考え、クラスを用いて実装した。

## 実装したクラス

- AIStatus：特定のゲームオブジェクトからの距離やAIの座標などの情報を表すクラス
  - Position：座標
  - Distance：特定のゲームオブジェクトあるいは座標からの距離
- AIPred：AIが次の行動に移る条件になるクラス AIStatusを用いる場合がある
  - Above：AIStatusの値が設定した値より大きいかどうか
  - Below：AIStatusの値が設定した値より小さいかどうか
  - AndPred：2つのAIPredを合成し、両方が満たされるかどうか
  - At：AIStatusの値が設定した値と等しいかどうか
  - Between：AIStatusの値が設定した2つの値の間にあるかどうか AndPredを用いて作成した
  - Keep：1つのPredが満たされた状態が一定時間続いたかどうか
  - KeepFrame：Keepのフレーム数バージョン
  - Once：1フレーム・1回だけ
  - True：常に満たされている
  - Wait：一定時間待機する
- AITask：AIの行動を表すクラス
  - Approach：特定のゲームオブジェクトに一定の速度で近づく
  - Attack：AIのSpriteの色を変える
  - CompTask：2つのAITaskを合成し、同時に実行する
  - Move：特定の座標に一定の速度で近づく
- AI：AITaskをリストで持ち、先頭から実行する リストが空になると新しいリストを得る関数を実行する

以下コード例
```gdscript
extends AI

# プレイヤーに近づき、一定距離より近づいたら1度だけ攻撃する
func next_movement() -> void:
	var player = get_node("../Player")
	tasks = [
		Approach.new(self, player, 240, Below.new(self, 120, Distance.new(self, player))),
		Attack.new(self, Once.new(self))
	]
```

十分なAIPredとAIStatusの実装があれば、AIの`next_movement()`関数だけ実装すればAIを記述できる。条件分岐を行う場合は、この関数で行うのが望ましい。

## 改善点

- ほとんどのクラスのコンストラクタにAIを引数で渡しており、可読性が低くなっている
- gdscriptの仕様上仕方ない部分があるものの、型関連でのバグが起こりやすい
