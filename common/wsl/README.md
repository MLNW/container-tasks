# WSL distro

## Copy files from another WSL instance

In the **old** instance:

```console
mkdir -p /mnt/wsl/share
sudo mount --bind / /mnt/wsl/share
```

In the **new** instance:

```console
cp --archive --verbose /mnt/wsl/share/home/dev/coding .
cp --archive --verbose /mnt/wsl/share/home/dev/.zsh_history .
```
