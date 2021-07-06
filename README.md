# My dotfiles

近く新しいPCを購入予定のため、その環境移行用にと当レポジトリを作成しました。
それ以後も更新していくかは現状未定ですが、gitやmd記法等未だ勉強中の要素が多々あるため、実験がてらしばらくの間は管理に挑戦してみようと思います(そのため記述には間違い等が含まれる可能性があります...)。

 1. [Structure](#structure)
 1. [Vim Setting Files](#vim)
 1. [NeoVim Setting Files](#neovim)
 1. [Extra Files](#extra-files)

## Structure

```sh
.
├── .config
│   ├── nvim
│   │   ├── coc-settings.json
│   │   └── init.vim
│   └── ranger
│       ├── rc.conf
│       └── rifle.conf
├── .vim
│   ├── autoload
│   │   ├── init
│   │   │   ├── basic.vim
│   │   │   ├── mapping.vim
│   │   │   └── plugins.vim
│   │   ├── myplugconfig.vim
│   │   └── plug.vim
│   └── coc-settings.json
├─── sub
│   └── coc_ex_list.txt
├── .Brewfile
├── .eslintrc.json
├── .tmux.conf
└── .vimrc
```

## Vim

`.vim/`をメインディレクトリとして下図の構造を取る。
`.vimrc`は独立しており、ホームディレクトリ(~)直下に配置される。

```sh
.
├── .vim
│   ├── autoload
│   │   ├── init
│   │   │   ├── basic.vim
│   │   │   ├── mapping.vim
│   │   │   └── plugins.vim
│   │   ├── myplugconfig.vim
│   │   └── plug.vim
│   └── coc-settings.json
└── .vimrc
```

* [`.vimrc`](#vimrc) : vimの起動時(+nvim)最初に読み込まれる
* `autoload/` : .vimrcによって次に読み込まれるファイル群
  * `init/` : 各種設定ファイル群
    * `basic.vim` : エディタの設定等標準的な設定
    * `mapping.vim` : キーマップ設定
    * `plugins.vim` : プラグインリスト(vim-plugを使用)、カラースキームの起動時読込
  * `plug.vim` : [vim-plug](https://github.com/junegunn/vim-plug)メインファイル(標準のまま)
    インストールの指示通りに`autoload/`配下へ保存し、標準のまま改変しない。
* `coc-settings.json` : [Coc](https://github.com/neoclide/coc.nvim)用の設定ファイル
  vim/nvim双方で兼用としているため、ローカル環境下に存在する同名のファイルそれぞれを、`dotfiles/`配下の当ファイルにシンボリックリンクで繋ぎ、設定を同期させています。

### .vimrc

各種設定を`basic`, `mapping`, `plugins`, `myplugconfig`と分割することで、主ファイルである`.vimrc`をナビゲーター的に扱えるようになりました。各プラグインの設定は、個別に作成して…という方法が正しいのかもしれませんが、色々と試してみようと消して入れてを頻繁に繰り返してしまうので、しばらくは`myplugconfig`で一本化することにしています。

```vim
runtime! autoload/init/*.vim
runtime! autoload/myplugconfig.vim
```

## NeoVim

```sh
.
└── .config
    └── nvim
        ├── coc-settings.json
        └── init.vim
```

* `.config` : ホームディレクトリ直下の各種設定ファイル保存用ディレクトリ
  * [`nvim/`](#neovim) : 各種設定ファイル群
    * `coc-settings.json` : Coc用の設定ファイル(上記参照)
    * [`init.vim`](#initvim) : nvimの起動時最初に読み込まれる

### init.vim

NeoVim起動後の`:help nvim`コマンドで表示される、`Transitioning from Vim *nvim-from-vim*`の項目に従って下記のように記述。これによって`.vimrc`に到達後各設定ファイルを読み込んでくれるようです。

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

上記のようにvim/nvimで各設定ファイルを兼用しているため、ファイル内の記述に気をつけること。例えば、`TreeSitter`や`Ranger`はvimに対応していないので、下記(`plugins.vim`)のように条件分岐させることでエラーが起こらないようにしています。

 ```vim
 if has("nvim")
      " --for better syntax highlighting
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
      " --ranger as a file explorer
      Plug 'kevinhwang91/rnvimr'
 endif
 ```

## Extra Files

```sh
.
├── .config
│   └── ranger
│       ├── rc.conf
│       └── rifle.conf
├─── sub
│   └── coc_ex_list.txt
├── .Brewfile
├── .eslintrc.json
└── .tmux.conf
```

* `ranger` : nvim内の`rnvimr`用
  * `rc.conf`
  * `rifle.conf`
* `sub/` : メモ等
  * `coc_ex_list.txt` : Coc Extensionsの一覧
* `.Brewfile` : Homebrewのbundleファイル。環境移行用。
* `.eslitrc.json` : eslint用のルールを指定
* `.tmux.conf` : tmuxの設定ファイル(キーの変更(C-b => C-t)等々)
