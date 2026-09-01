pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

Singleton {
	id: root

	readonly property var device: UPower.displayDevice
	readonly property real percent: {
		const p = device?.percentage ?? 0;
		return p <= 1 ? p * 100 : p;
	}
	readonly property bool charging: device
		? device.state === UPowerDeviceState.Charging
			|| device.state === UPowerDeviceState.FullyCharged
		: false

	property string profile: ""

	readonly property string label: Math.round(percent) + "%"

	function icon() {
		if (charging) return "󰂄";
		const icons = ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
		return icons[Math.min(9, Math.floor(percent / 10))];
	}

	function profileIcon() {
		if (profile === "performance") return "󰓅";
		if (profile === "power-saver") return "󰾆";
		return "󰾅";
	}

	function cycleProfile() {
		const order = ["power-saver", "balanced", "performance"];
		const next = order[(order.indexOf(profile) + 1) % order.length];
		Quickshell.execDetached(["powerprofilesctl", "set", next]);
		profile = next;
	}

	Process {
		id: proc
		command: ["powerprofilesctl", "get"]
		stdout: SplitParser {
			onRead: data => {
				const p = data.trim();
				if (p !== "") root.profile = p;
			}
		}
	}

	Timer {
		interval: 5000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: proc.running = true
	}
}
