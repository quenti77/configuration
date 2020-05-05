### Configuration de vim

```bash
sudo apt install vim
```

Création d'un fichier de configuration .vimrc dans le dossier des utilisateurs :

### Création fichier .vimrc et dossier .vim et link vimrc

```bash
cd ~
mkdir -p .vim/{autoload,colors,syntax,plugin,spell,config}
touch .vim/vimrc
ln -s ~/.vim/vimrc ~/.vimrc
```

### Installation de pathogen

> Nécessite d'avoir installer git avant !

```bash
cd ~/.vim
git clone https://github.com/tpope/vim-pathogen.git pathogen
cd autoload
ln -s ../pathogen/autoload/pathogen.vim .

# Création du dossier bundle
cd ~/.vim
mkdir -p bundle
cd bundle
```

#### Mettre à jour pathogen

```bash
cd ~/.vim/pathogen
git pull
```

### Installation des plugins
- nerdtree

#### NerdTree

```bash
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
```

### Fichiers de configuration de vim

- .vim/vimrc
```vim
" Ajout lecture des fichiers .vim du dossier config
runtime! config/**/*.vim

" Remove VI compatible
set nocompatible

" Active line number
set number

" Active pathogen
call pathogen#infect()

" Active file syntax
filetype plugin indent on
syntax on

" Indentation intelligente
set smartindent
set autoindent

set tabstop=4
set shiftwidth=4
set expandtab

" Souris actif
set mouse=a

" Active plugins
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <S-s> :NERDTreeToggle<CR>

" Mapping
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <C-o>:update<CR>

" Tab navigation like Firefox.
nnoremap <C-S-r> :tabprevious<CR>
nnoremap <C-r>   :tabnext<CR>
nnoremap <C-t>   :tabnew<CR>
inoremap <C-S-r> <Esc>:tabprevious<CR>i
inoremap <C-r>   <Esc>:tabnext<CR>i
inoremap <C-t>   <Esc>:tabnew<CR>
```
