pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root

	property bool powered: false
	property int connectedCount: 0
	property string deviceName: ""

	// paired devices: {mac, name, connected}
	property var devices: []
	property var _tmp: []

	// discovered (unpaired) devices: {mac, name}
	property var discovered: []
	readonly property bool discovering: scanProc.running

	readonly property string label: {
		if (!powered || connectedCount === 0) return "";
		return deviceName !== "" ? deviceName : connectedCount + " dev";
	}

	function icon() {
		if (!powered) return "󰂲";
		return connectedCount > 0 ? "󰂱" : "󰂯";
	}

	function rescan() {
		if (listProc.running) return;
		_tmp = [];
		listProc.running = true;
	}

	function setPower(on) {
		Quickshell.execDetached(["bluetoothctl", "power", on ? "on" : "off"]);
		powered = on;
		refreshTimer.restart();
	}

	function toggleDevice(mac, connected) {
		Quickshell.execDetached(["bluetoothctl",
			connected ? "disconnect" : "connect", mac]);
		refreshTimer.restart();
	}

	function startScan() {
		if (scanProc.running || !powered) return;
		discovered = [];
		scanProc.running = true;
	}

	function pairAndConnect(mac) {
		// mac comes from our own [NEW] Device regex, safe to inline
		Quickshell.execDetached(["sh", "-c",
			"bluetoothctl pair " + mac +
			" && bluetoothctl trust " + mac +
			" && bluetoothctl connect " + mac]);
		refreshTimer.restart();
	}

	// discovery: one process, devices parsed live from its output
	Process {
		id: scanProc
		command: ["bluetoothctl", "--timeout", "10", "scan", "on"]
		stdout: SplitParser {
			onRead: data => {
				const line = String(data).replace(/\x1b\[[0-9;]*m/g, "");
				const m = line.match(/\[NEW\] Device ([0-9A-Fa-f:]{17}) (.+)/);
				if (!m) return;
				const mac = m[1];
				const name = m[2].trim();
				if (name === mac.replace(/:/g, "-")) return; // unnamed device
				if (root.discovered.some(d => d.mac === mac)) return;
				if (root.devices.some(d => d.mac === mac)) return;
				root.discovered = root.discovered.concat([{ mac: mac, name: name }]);
			}
		}
		onExited: {
			// pick up anything that paired meanwhile
			statusProc.running = true;
			root.rescan();
		}
	}

	Process {
		id: statusProc
		command: ["sh", "-c",
			"p=$(bluetoothctl show 2>/dev/null | awk '/Powered/{print $2; exit}'); " +
			"c=$(bluetoothctl devices Connected 2>/dev/null); " +
			"n=$(printf '%s' \"$c\" | head -1 | cut -d' ' -f3-); " +
			"d=$(printf '%s' \"$c\" | grep -c Device); " +
			"echo \"$p|$d|$n\""]
		stdout: SplitParser {
			onRead: data => {
				const parts = data.trim().split("|");
				root.powered = parts[0] === "yes";
				root.connectedCount = parseInt(parts[1] ?? "0") || 0;
				root.deviceName = parts[2] ?? "";
			}
		}
	}

	Process {
		id: listProc
		command: ["sh", "-c",
			"bluetoothctl devices 2>/dev/null | while read -r _ mac name; do " +
			"s=0; bluetoothctl info \"$mac\" 2>/dev/null " +
			"| grep -q 'Connected: yes' && s=1; " +
			"echo \"$s|$mac|$name\"; done"]
		stdout: SplitParser {
			onRead: data => {
				const parts = data.trim().split("|");
				if (parts.length < 3) return;
				root._tmp.push({
					connected: parts[0] === "1",
					mac: parts[1],
					name: parts.slice(2).join("|")
				});
			}
		}
		onExited: {
			const list = root._tmp.slice();
			list.sort((a, b) => b.connected - a.connected);
			root.devices = list;
		}
	}

	Timer {
		id: refreshTimer
		interval: 2500
		onTriggered: {
			statusProc.running = true;
			rescan();
		}
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: statusProc.running = true
	}
}
