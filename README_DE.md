# Game Input Remapper - Deutsche Anleitung

Die Hauptsprache des Programms und der GitHub-Seite ist Englisch. Im Programm kann oben rechts mit **Deutsch / English** umgeschaltet werden.

Der Remapper löst ein spezielles Problem: Razer Synapse oder eine andere Maus-/Makrosoftware erzeugt eine Tastatureingabe, Windows erkennt sie korrekt, aber ein Spiel ignoriert sie. Das Standardprofil ist für **Crimson Desert** abgestimmt.

## Schnellstart für Crimson Desert

1. ZIP in einen normalen Ordner entpacken, z. B. `C:\Tools\GameInputRemapper`.
2. `Start_GameInputRemapper.cmd` starten.
3. Profil **Crimson Desert** ausgewählt lassen.
4. In Razer Synapse der gewünschten Naga-Seitentaste eine normale Tastaturtaste zuweisen, z. B. Naga 1 -> `F11`. In Synapse **kein Turbo/Autofeuer** aktivieren.
5. Im Remapper in Zeile 1 auf **Eingang lernen** klicken und Naga 1 druecken. Dabei werden Taste und Raw-Input-Gerät gemeinsam gespeichert.
6. Auf **Taste wählen** klicken und die Taste druecken, die das Spiel erhalten soll, z. B. `Numpad 1`.
7. In Crimson Desert die gewuenschte Aktion auf `Numpad 1` legen.
8. **Tastendruckdauer** für den ersten Test auf **100 ms** lassen. Dieser Wert ist absichtlich Standard, weil Crimson Desert sehr kurze erzeugte Tastendrücke teilweise verpasst hat.
9. Crimson Desert in den Vordergrund bringen. Der Status muss `Crimson Desert: im Vordergrund` anzeigen.
10. Naga-Taste einmal druecken.

Das Spiel muss **nicht** über das Script gestartet werden. Script vor oder nach dem Spiel starten funktioniert. Der Button **Spiel starten** ist nur Komfort.

## Autofeuer

Wenn **Autofeuer** für eine Zeile aktiviert ist, reicht in Synapse ein normaler Tastendruck.

Beim Halten der Naga-Taste macht der Remapper selbst:

`Taste DOWN -> Tastendruckdauer -> Taste UP -> Pause -> nächster Tastendruck`

Bei 100 ms Tastendruckdauer ergibt sich ungefähr:

- Pause `0 ms` -> ca. 10 Eingaben/s
- Pause `100 ms` -> ca. 5 Eingaben/s
- Pause `400 ms` -> ca. 2 Eingaben/s

`0 ms` Pause wurde bei der Entwicklung erfolgreich getestet.

## Tastendruckdauer

Die **Tastendruckdauer (ms)** ist nicht dasselbe wie die Autofeuer-Pause. Sie bestimmt, wie lange die erzeugte Zieltaste gedrueckt bleibt.

Standard: **100 ms**. Fuer Crimson Desert sollte dieser Wert zunaechst beibehalten werden. Wenn ein anderes Spiel mit kürzeren Impulsen sicher funktioniert, kann im entsprechenden Profil z. B. 30 oder 50 ms eingestellt werden.

## Profile für andere Spiele

Oben kann zwischen Profilen umgeschaltet werden.

- **Neu** kopiert das aktuelle Profil unter einem neuen Namen. Dadurch können die gleichen Naga-Zuordnungen leicht für ein weiteres Spiel verwendet werden.
- **Speichern** speichert explizit. Die meisten Änderungen werden zusätzlich automatisch gespeichert.
- **Löschen** entfernt das aktuelle Profil.

Pro Profil werden u. a. gespeichert:

- Prozessname des Spiels
- Steam/EXE-Startart
- Steam App-ID bzw. EXE-Pfad
- Tastendruckdauer
- alle sieben Mappings
- Autofeuer und Pause je Mapping

Der Remapper sendet nur dann Eingaben, wenn der Prozess des ausgewählten Profils im Vordergrund ist.

## Prozessname finden

Task-Manager -> **Details** -> Spiel-EXE suchen -> `.exe` weglassen.

Beispiel: `CrimsonDesert.exe` -> `CrimsonDesert`.

## Raw Input Diagnose

Mit **Raw Input Diagnose** sieht man, was Windows tatsaechlich empfaengt. Wichtig sind bei Keyboard-Ereignissen insbesondere `Device`, `VK`, Tastenname, `Scan` und `DOWN/UP`.

Das Diagnosefenster übernimmt temporaer die Raw-Input-Registrierung. Deshalb das Diagnosefenster vor dem eigentlichen Spieltest wieder schliessen. Danach registriert sich das Hauptfenster automatisch erneut.

## Desktop-Verknuepfung

`Create_Desktop_Shortcut.cmd` einmal starten. Dadurch wird eine Verknuepfung **Game Input Remapper** auf dem Desktop angelegt.

## Konfiguration

Beim ersten Start wird `profiles.ini` neben dem Script angelegt. Die Datei enthält auch die gelernten Raw-Input-Gerätepfade und ist daher rechnerbezogen. Sie wird vom Git-Repository bewusst ignoriert.

Beim ersten Start wird außerdem versucht, vorhandene Einstellungen aus den alten Crimson-Desert-Versionen v8/v9 aus der Registry zu übernehmen.

## Fehlersuche

Wenn PowerShell sofort geschlossen wird, `Start_GameInputRemapper_Debug.cmd` verwenden. Das Fenster bleibt dann offen und zeigt die Fehlermeldung.

Wenn eine Seitentaste nur beim Spammen funktioniert, die **Tastendruckdauer** erhöhen. 100 ms ist der für Crimson Desert ermittelte Startwert.

Wenn der Status dauerhaft `wartet` anzeigt, stimmt meistens der **Prozessname** nicht.

Wenn das Spiel als Administrator läuft, muss der Remapper unter Umständen ebenfalls als Administrator gestartet werden.

## Hinweis zu Anti-Cheat und Spielregeln

Das Programm versucht nicht, Anti-Cheat zu umgehen. Es erzeugt Windows-Tastatureingaben und kann optional wiederholte Eingaben erzeugen. Bei Multiplayer-Spielen können Makros oder Autofeuer laut Spielregeln untersagt sein. Die jeweiligen Regeln sind einzuhalten.

## Lizenz

MIT. Siehe `LICENSE`.
