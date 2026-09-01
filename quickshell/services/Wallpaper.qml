pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root

	readonly property string dir: Quickshell.env("HOME") + "/.config/wallpapers"
	readonly property string stateFile: Quickshell.env("HOME") + "/.cache/quickshell-wallpaper"

	property string current: ""
	property var files: []
	property var _tmp: []

	function set(path) {
		current = path;
		Quickshell.execDetached(["sh", "-c",
			"printf %s \"$0\" > \"$1\"", path, stateFile]);
	}

	function random() {
		const others = files.filter(f => f !== current);
		if (others.length === 0) return;
		set(others[Math.floor(Math.random() * others.length)]);
	}

	function rescan() {
		if (scanProc.running) return;
		_tmp = [];
		scanProc.running = true;
	}

	Process {
		id: scanProc
		command: ["sh", "-c",
			"find \"$0\" -type f \\( -iname '*.jpg' -o -iname '*.jpeg' " +
			"-o -iname '*.png' -o -iname '*.webp' \\) 2>/dev/null | sort",
			root.dir]
		stdout: SplitParser {
			onRead: data => {
				const line = String(data).trim();
				if (line !== "") root._tmp.push(line);
			}
		}
		onExited: root.files = root._tmp.slice()
	}

	// restore last wallpaper
	Process {
		id: loadProc
		command: ["cat", root.stateFile]
		running: true
		stdout: SplitParser {
			onRead: data => {
				const line = String(data).trim();
				if (line !== "") root.current = line;
			}
		}
	}

	Component.onCompleted: rescan()
}
