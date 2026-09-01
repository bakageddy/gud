pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root

	// active connection: "eth", "wifi", or "" when disconnected
	property string kind: ""
	property string name: ""
	property int strength: 0
	readonly property bool connected: kind !== ""
	readonly property string label: {
		if (kind === "eth") return "eth";
		if (kind === "wifi") return name;
		return "off";
	}

	// radios & devices
	property bool wifiEnabled: true
	property string ethDevice: ""
	property string ethState: "" // connected / disconnected / unavailable
	readonly property bool ethConnected: ethState === "connected"

	// wifi scan results: {ssid, strength, secured, inUse, known}
	property var networks: []
	readonly property bool scanning: scanProc.running

	property var _knownTmp: []
	property var _wifiTmp: []

	function icon() {
		if (kind === "") return "󰤭";
		if (kind === "eth") return "󰈀";
		return strengthIcon(strength);
	}

	function strengthIcon(s) {
		if (s > 80) return "󰤨";
		if (s > 55) return "󰤥";
		if (s > 30) return "󰤢";
		return "󰤟";
	}

	function rescan() {
		if (scanProc.running) return;
		_knownTmp = [];
		_wifiTmp = [];
		scanProc.running = true;
	}

	function setWifi(on) {
		Quickshell.execDetached(["nmcli", "radio", "wifi", on ? "on" : "off"]);
		wifiEnabled = on;
		refreshTimer.restart();
	}

	function toggleEthernet() {
		if (ethDevice === "") return;
		Quickshell.execDetached(["nmcli", "device",
			ethConnected ? "disconnect" : "connect", ethDevice]);
		refreshTimer.restart();
	}

	function connectTo(ssid, password) {
		if (password !== undefined && password !== "")
			Quickshell.execDetached(["nmcli", "device", "wifi", "connect", ssid,
				"password", password]);
		else
			Quickshell.execDetached(["nmcli", "device", "wifi", "connect", ssid]);
		refreshTimer.restart();
	}

	// active connection poll
	Process {
		id: statusProc
		command: ["sh", "-c",
			"eth=$(nmcli -t -f NAME,TYPE connection show --active 2>/dev/null " +
			"| grep ':802-3-ethernet$' | head -1 | cut -d: -f1); " +
			"if [ -n \"$eth\" ]; then echo \"eth:$eth:100\"; else " +
			"w=$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi 2>/dev/null " +
			"| grep '^yes' | head -1); " +
			"if [ -n \"$w\" ]; then echo \"wifi:${w#yes:}\"; else echo none; fi; fi"]
		stdout: SplitParser {
			onRead: data => {
				const line = data.trim();
				if (line === "" || line === "none") {
					root.kind = "";
					root.name = "";
					root.strength = 0;
					return;
				}
				const parts = line.split(":");
				root.kind = parts[0];
				root.name = parts[1] ?? "";
				root.strength = parseInt(parts[2] ?? "0") || 0;
			}
		}
	}

	// wifi radio + ethernet device state poll
	Process {
		id: stateProc
		command: ["sh", "-c",
			"r=$(nmcli radio wifi 2>/dev/null); " +
			"e=$(nmcli -t -f DEVICE,TYPE,STATE dev status 2>/dev/null " +
			"| grep ':ethernet:' | head -1); " +
			"echo \"$r|$e\""]
		stdout: SplitParser {
			onRead: data => {
				const parts = data.trim().split("|");
				root.wifiEnabled = parts[0] === "enabled";
				const e = (parts[1] ?? "").split(":");
				root.ethDevice = e[0] ?? "";
				root.ethState = e[2] ?? "";
			}
		}
	}

	// wifi scan; K: lines are saved connections, W: lines are scan results
	Process {
		id: scanProc
		command: ["sh", "-c",
			"nmcli -t -f NAME connection show 2>/dev/null | sed 's/^/K/'; " +
			"nmcli -t -f IN-USE,SIGNAL,SECURITY,SSID device wifi list 2>/dev/null " +
			"| sed 's/^/W/'"]
		stdout: SplitParser {
			onRead: data => {
				const line = String(data).replace(/\s+$/, "");
				if (line.startsWith("K")) root._knownTmp.push(line.slice(1));
				else if (line.startsWith("W")) root._wifiTmp.push(line.slice(1));
			}
		}
		onExited: {
			const nets = [];
			const seen = {};
			for (const raw of root._wifiTmp) {
				const parts = raw.split(":");
				if (parts.length < 4) continue;
				const inUse = parts[0].trim() === "*";
				const strength = parseInt(parts[1]) || 0;
				const sec = (parts[2] ?? "").trim();
				const ssid = parts.slice(3).join(":").replace(/\\:/g, ":").trim();
				if (ssid === "") continue;
				if (seen[ssid]) {
					if (inUse) seen[ssid].inUse = true;
					continue;
				}
				const entry = {
					ssid: ssid,
					strength: strength,
					secured: sec !== "" && sec !== "--",
					inUse: inUse,
					known: root._knownTmp.indexOf(ssid) !== -1
				};
				seen[ssid] = entry;
				nets.push(entry);
			}
			nets.sort((a, b) => (b.inUse - a.inUse) || (b.strength - a.strength));
			root.networks = nets;
		}
	}

	Timer {
		id: refreshTimer
		interval: 2500
		onTriggered: {
			statusProc.running = true;
			stateProc.running = true;
			rescan();
		}
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: {
			statusProc.running = true;
			stateProc.running = true;
		}
	}
}
