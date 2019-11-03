### Configuration de git

Dans le fichier ~/.gitconfig (le créer si besoin)
```ini
[user]
    email = your@address.email
    name = your_nickname

[alias]
    lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    lg = !"git lg1"

    s = status
    d = diff --cached
    dl = diff HEAD HEAD^

    a = add --all
    ap = add --all -p

    c = commit
    cm = commit -m

    pl = pull --rebase origin
    pld = pull --rebase origin develop
    ps = push origin

    ch = checkout
    chd = checkout develop
    chn = checkout -b
    chf = !"f() { git checkout \"feature/$1\"; }; f"
    chr = !"f() { git checkout \"release/$1\"; }; f"

    rb = branch -D

    st = stash
    stp = stash pop
    stc = stash clear

    ri = rebase -i

    f = flow
[pull]
    rebase = true
```
