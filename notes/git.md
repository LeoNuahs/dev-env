# Git
This needs `less`, `util-linux`, `man-db`, and `man-pages` to run.

1. `git config --global init.defaultBranch main`
2. `git config --add --global user.name LeoNuahs`
3. `git config --add --global user.email leonuahs@gmail.com`
4. `git config --global pull.rebase true`
5. Setup [gitcredentials](https://git-scm.com/docs/gitcredentials)
  - `git config --global credential.helper store` or `git config --global credential.helper cache` if lazy and fine with insecure
  - Edit `.git/config` for [static configuration](https://git-scm.com/docs/gitcredentials#_avoiding_repetition)
