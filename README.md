## Common NixOS instructions

* Update flake

``` sh
$ sudo nix flake update
```

* Rebuilt flake

``` sh
$ sudo nixos-rebuild switch --flake '.#ideapad'
```

* List generations

``` sh
$ sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```
* Remove old generations

``` sh
$ sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3
$ sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
$ sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 7d
```

* Free up some disk space

``` sh
$ nix-collect-garbage
```

