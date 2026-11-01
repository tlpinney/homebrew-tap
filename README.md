# tlpinney/homebrew-tap

[Homebrew](https://brew.sh) formulas for my projects.

```sh
brew tap tlpinney/tap
brew trust --formula tlpinney/tap/<formula>
brew install tlpinney/tap/<formula>
```

Homebrew asks you to trust formulas from taps outside Homebrew itself;
`brew trust --formula` trusts just that one (`brew trust --tap tlpinney/tap`
would trust everything here). For example:

```sh
brew tap tlpinney/tap
brew trust --formula tlpinney/tap/mapterm
brew install tlpinney/tap/mapterm
```

## Formulas

| Formula | What it is |
|---|---|
| `mapterm` | A map in your terminal: OpenStreetMap vector tiles drawn with braille characters, and a ratatui map widget. [mapterm.com](https://mapterm.com) · [source](https://github.com/tlpinney/mapterm) |

## Notes

- Formulas build from source unless they say otherwise, so they work on Apple
  silicon, Intel Macs and Linux.
- Problems with a formula: open an issue here. Problems with the program itself
  go to its own repository.
