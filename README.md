# Game Input Remapper

A small Windows GUI remapper for a very specific but annoying problem: a mouse or macro utility can generate a perfectly valid keyboard event, Windows sees it, but a game ignores it because the event does not look like normal keyboard input to the game's input path.

The default profile is tuned for **Crimson Desert** and was developed around a **Razer Naga Trinity / Razer Synapse** setup. The design is intentionally generic so additional games and setups can be stored as profiles.

**Languages:** English is the default UI language. Click **Deutsch** in the top-right corner to switch the complete main UI to German. The language choice is saved.

## What it does

Game Input Remapper learns both the keyboard key emitted by Synapse and the specific Raw Input device that emitted it. When the configured game is in the foreground, the remapper converts that input into a new Windows keyboard event that the game can recognize.

It also provides:

- 7 configurable mappings, intended for a Naga-style side panel
- adjustable **key press duration**, default **100 ms**
- optional **Auto fire** per mapping
- configurable Auto-fire pause in milliseconds
- multiple game/setup profiles in a dropdown
- Steam or direct-EXE launch configuration per profile
- Raw Input diagnostics
- automatic migration of the old Crimson Desert v8/v9 registry settings on first start
- no installation required

## Requirements

- Windows 10 or Windows 11
- Windows PowerShell 5.1 (included with normal Windows installations)
- a mouse/macro utility such as Razer Synapse that can assign keyboard keys to side buttons

Administrator rights are normally **not** required. If the game itself is explicitly running as Administrator, the remapper may also need to be started as Administrator because Windows blocks lower-integrity applications from injecting input into higher-integrity applications.

## Crimson Desert: exact quick-start

This is the setup that should work out of the box.

1. Extract the release ZIP to a normal folder, for example `C:\Tools\GameInputRemapper`.
2. Run `Start_GameInputRemapper.cmd`.
3. Leave the profile set to **Crimson Desert**.
4. In Razer Synapse, assign a normal keyboard key to each Naga side button you want to use. Example: Naga 1 -> `F11`. Do **not** enable Synapse Turbo/Auto-repeat; the remapper can handle repeat itself.
5. In the remapper, click **Learn input** on row 1 and press Naga 1. The program stores both `F11` and the Raw Input device that generated it.
6. Click **Choose target** on row 1 and press the keyboard key that Crimson Desert should receive, for example `Numpad 1`.
7. In Crimson Desert, bind the desired action to that target key (`Numpad 1` in this example).
8. Leave **Key press duration** at **100 ms** for the first test. That value is deliberately the default because Crimson Desert was unreliable with very short synthetic key presses.
9. Put Crimson Desert in the foreground. The status box should change to `Crimson Desert: foreground`.
10. Press the Naga side button once. The action should fire once.

The game does **not** have to be launched from the remapper. The remapper may be started before or after the game. The **Start game** button is only a convenience feature.

## Auto fire

Auto fire is handled by the remapper, so Synapse only needs to send one normal key while the side button is held.

For a mapping:

1. Enable the **Auto fire** checkbox.
2. Set **Pause ms**.
3. Hold the Naga button.
4. The remapper sends one key press for the configured **Key press duration**, releases it, waits for **Pause ms**, and starts the next press.

With the Crimson Desert default of a 100 ms key press:

- `Pause 0 ms` -> roughly 10 presses/second
- `Pause 100 ms` -> roughly 5 presses/second
- `Pause 400 ms` -> roughly 2 presses/second

`Pause 0 ms` was specifically tested successfully during development.

## Key press duration

**Key press duration (ms)** controls how long each generated target key remains down before it is released.

The default is **100 ms**. Do not reduce it merely because a lower number looks faster. Some games poll input in a way that can miss very short injected key presses. Crimson Desert was exactly such a case during testing.

If another game reacts reliably at 30-50 ms, create a separate profile and save the shorter duration there.

## Profiles for other games

Use the profile dropdown at the top.

- **New** duplicates the current profile, including mappings. This is useful when the same Naga layout is used in several games.
- **Save** explicitly saves the current profile. Most changes are also auto-saved.
- **Delete** removes the selected profile. At least one profile must remain.

For each game profile, configure:

- **Process name**: the game's executable name without `.exe`, for example `CrimsonDesert`
- Steam or Direct EXE launch mode
- Steam App ID or executable path
- Key press duration
- mappings and Auto-fire settings

The remapper only sends target keys while the selected profile's process is the **foreground application**. This prevents the mappings from firing into your browser, desktop, chat application, etc.

## How to find the process name

If you do not know the process name:

1. Start the game.
2. Open Windows Task Manager.
3. Open the **Details** tab.
4. Find the game's `.exe`.
5. Enter the filename without `.exe` into **Process name**.

Example: `CrimsonDesert.exe` -> `CrimsonDesert`.

## Raw Input diagnostics

Click **Raw Input diagnostics** if a side button is not behaving as expected.

For keyboard entries, the important fields are:

- `Device`: which Raw Input device generated the event
- `VK`: Windows virtual-key code
- key name, for example `F11`
- `Scan`: scan code
- `DOWN` / `UP`

The diagnostic window temporarily becomes the Raw Input receiver. Close it before testing remapping in the game. When it closes, the main window automatically registers for Raw Input again.

## Desktop shortcut

Run `Create_Desktop_Shortcut.cmd` once. It creates **Game Input Remapper.lnk** on the current user's desktop.

Alternatively, create a normal Windows shortcut to `Start_GameInputRemapper.cmd` yourself.

## Files

- `GameInputRemapper.ps1` - application
- `Start_GameInputRemapper.cmd` - normal launcher
- `Start_GameInputRemapper_Debug.cmd` - launcher that leaves the PowerShell console open if troubleshooting is required
- `Create_Desktop_Shortcut.cmd` - creates a desktop shortcut
- `profiles.example.ini` - documented example configuration
- `profiles.ini` - generated automatically on first run; stores your profiles and learned Raw Input device paths

`profiles.ini` is deliberately excluded from Git because Raw Input device paths are machine-specific.

## Troubleshooting

### The side button is visible in Windows/Synapse but nothing happens in the game

Re-learn the input in the correct profile. **Learn input** stores both the assigned keyboard key and its Raw Input device. Merely typing the same key on the physical keyboard is not the same thing.

### It works only if I spam the button

Increase **Key press duration**. Start at 100 ms. This symptom was the reason the duration feature was added for Crimson Desert.

### Auto fire does not repeat

Make sure the **Auto fire** checkbox is enabled for that row. Synapse should send a normal held keyboard key; do not also enable Synapse Turbo for the same button.

### The status always says waiting

The **Process name** is wrong or the game is not the foreground application. Use Task Manager -> Details and enter the executable name without `.exe`.

### It works outside the game but not in the game

Check whether the game is running as Administrator. If it is, try starting the remapper as Administrator as well. Also be aware that some anti-cheat systems intentionally reject or prohibit synthetic input.

### PowerShell closes immediately

Run `Start_GameInputRemapper_Debug.cmd` and copy the complete error text into a bug report.

## Configuration and privacy

The program is local. It does not send input logs or configuration anywhere. `profiles.ini` is stored next to the script.

The learned Raw Input device path can contain hardware-specific identifiers. That is why the real `profiles.ini` is ignored by Git and should generally not be posted publicly unless you understand what it contains.

## Anti-cheat / game rules

This utility does not attempt to bypass anti-cheat. It generates Windows keyboard input and provides optional repeat/Auto-fire behavior. Some multiplayer games prohibit macros, automated repeat, or injected input even when the software is technically able to send it. Follow the rules of the game you use it with.

## License

MIT License. See `LICENSE`.
