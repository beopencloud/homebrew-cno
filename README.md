# CNO Homebrew repo

> **Deprecation notice**
>
> This tap is deprecated. The official Door CLI distribution has moved to the [doorcloud/door](https://github.com/doorcloud/door) Homebrew tap.
> Use the new command to install doorctl:
> ```sh
> brew install doorcloud/door/doorctl
> ```
>
> Existing users can migrate with:
> ```sh
> brew uninstall doorctl
> brew untap beopencloud/cno
> brew install doorcloud/door/doorctl
> ```
>
> Releases now track [doorcloud/door/releases](https://github.com/doorcloud/door/releases).

Homebrew tap for Door CLI (`doorctl`).

## Requirements

- [Homebrew](https://brew.sh)

## Installation

```sh
brew tap beopencloud/cno
```

### macOS (Apple Silicon or Intel)

Pre-built binary via cask — no Xcode Command Line Tools required:

```sh
brew install --cask doorctl
```

### Linux

```sh
brew install doorctl
```

## Upgrade

```sh
brew update
brew upgrade --cask doorctl   # macOS
brew upgrade doorctl          # Linux
```

## Migrating from the legacy macOS formula

If you previously installed `beopencloud/cno/doorctl` as a formula:

```sh
brew uninstall doorctl
brew install --cask doorctl
```

Releases track [beopencloud/cno](https://github.com/beopencloud/cno/releases). The tap is bumped automatically after each prod tag publish.
