# traP1weekjissou 第1回　画面・シーン遷移の機構

## 考えたこと

シーン遷移において以下の2つの要素が必要不可欠であると考え、これらを満たすシーン遷移の機構を作ることを目的とした。

- シーン間での情報の受け渡しが可能であること
  - アクションゲームではマップの出入り位置、ハクスラでは装備強化画面で強化する装備などを情報としてシーン遷移時に与えたい
- シーン遷移の順序を記憶し、操作できること
  - 「戻る」機能などが実装できてほしい
  - キャラクターから装備強化画面に遷移した場合と装備一覧から装備強化画面に遷移した場合で「戻る」の挙動は異なる

また、シーン遷移の途中にアニメーションを再生するようにしている。

### シーン間での情報の受け渡し

思いついた方法は以下の3つで、今回は関数呼び出しによる方法を用いた

- グローバル変数を使う
  - シーンの種類が増えるとグローバル変数が増えすぎる懸念がある
- ファイルに情報を保存する
  - 遅そう
- 関数呼び出しやコンストラクタの引数を使う

### シーン遷移の順序

「戻る」機能が正確に動作するように、スタック状のデータ構造にシーン遷移の順序を保存し、操作することにした

## 実装に関すること

- AutoLoadでSceneManagerというシーンをシングルトン化する
  - シングルトン化することにより、個々のシーン構造が制限を受けず、どこからでも関数を呼び出せる
- シーン変更時に引数を与えることができ、シーンのinit_scene関数を呼び出すことができる
  - 引数もスタックに保存される
- 5つの関数を実装した（概要はソースコード参照）
  - start_root
  - to
  - replace
  - back
  - back_until

## 改善が必要な点

- 引数の保存に関して、参照型の引数を使うとbackを使った際にバグが発生しうる
- シーンをフルパスで指定する必要がある

## 参考文献

[シングルトン(自動読み込み) — Godot Engine (stable)の日本語のドキュメント](https://docs.godotengine.org/ja/stable/getting_started/step_by_step/singletons_autoload.html) 2021/06/27
