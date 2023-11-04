## Common NixOS instructions

* Update flake

``` sh
$ sudo nix flake update
```

* Rebuilt flake

``` sh
$ sudo nixos-rebuild switch --flake '.#ideapad'
```
