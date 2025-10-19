# WSL distro

## Copy files from another WSL instance

In the **old** instance:

```console
mkdir -p /mnt/wsl/share
sudo mount --bind / /mnt/wsl/share
find coding/ -type d -name node_modules -prune | xargs -I _ rm -rf _
find coding/ -type d -name target -prune | xargs -I _ rm -rf _
```

In the **new** instance:

```console
cp --recursive --preserve=all /mnt/wsl/share/home/dev/coding .
cp --recursive --preserve=all /mnt/wsl/share/home/dev/.zsh_history .
```
