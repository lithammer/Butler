# Butler

Small conveniences for World of Warcraft Forever.

- **Unusable items:** Tints items you cannot use with a transparent red overlay
  in Blizzard's bags.
- **Item borders:** Brightens green, blue, and purple item borders in bags and
  on the character screen.
- **Stat hints:** Shows gear upgrades and downgrades with a Warlock leveling
  profile and conservative stat comparisons for other gear and classes.
- **Merchant:** Automatically sells junk and repairs items at vendors.
- **Disenchant:** Alt-click an item in your bags to disenchant it.
- **Copy chat:** Adds a button on the left of the chat window to copy chat history.
  Skips messages the game's text box rejects so they cannot blank the whole copy.
- **Chat labels:** Uses `[G: Orgrimmar]` for General, `[LD: Orgrimmar]` for
  LocalDefense, `[G]` for Guild, `[T]` for Trade, and `[TS]` for Trade (Services).
  Hides channel numbers and keeps chat colors and links. Zone names follow
  the channel.
- **Whisper history:** Shows character and Battle.net whispers received while
  AFK when you return, with clickable sender names. The backlog clears after
  it is shown or the UI reloads.

## Checks

Install [StyLua](https://github.com/JohnnyMorganz/StyLua). Format Lua files with:

```sh
stylua .
stylua --check .
```

Run [wowlua-ls](https://github.com/TradeSkillMaster/wowlua-ls) with the
repo's Forever configuration:

```sh
wowlua_ls check --severity hint .
```

Enable the pre-commit hook in each checkout:

```sh
git config core.hooksPath .githooks
```
