import Quickshell
import Quickshell.Wayland
import QtQuick
import ".."
import "../services"

PanelWindow {
	id: win

	property var modelData
	screen: modelData

	// hide when the focused window is fullscreen
	readonly property bool hidden: ToplevelManager.activeToplevel?.fullscreen ?? false
	visible: !hidden

	anchors.top: true
	exclusiveZone: 32
	implicitWidth: 620
	implicitHeight: 440
	color: "transparent"
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.namespace: "notch"
	WlrLayershell.keyboardFocus: notch.panel !== ""
		? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

	mask: Region { item: notch }

	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}

	Fillet {
		anchors.top: parent.top
		anchors.right: notch.left
		anchors.rightMargin: -2
	}

	Fillet {
		mirrored: true
		anchors.top: parent.top
		anchors.left: notch.right
		anchors.leftMargin: -2
	}

	Rectangle {
		id: notch

		// "", "network", "bluetooth", or "wallpaper"
		property string panel: ""
		property bool expanded: hover.hovered || panel !== ""
		// latched on volume hover, released when the pointer leaves the notch
		property bool volumeMode: false
		onExpandedChanged: if (!expanded) volumeMode = false

		onPanelChanged: {
			if (panel !== "") volumeMode = false;
			if (panel === "network") Network.rescan();
			if (panel === "bluetooth") Bluetooth.rescan();
			if (panel === "wallpaper") Wallpaper.rescan();
		}

		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		width: panel !== "" ? 380
			: expanded ? row.implicitWidth + 48 : timeText.implicitWidth + 150
		height: panel !== "" ? panelCol.implicitHeight + 32
			: expanded ? 44 : 32
		color: Theme.bg
		bottomLeftRadius: 10
		bottomRightRadius: 10
		clip: true

		Behavior on width {
			NumberAnimation { duration: 500; easing.type: Easing.OutBack; easing.overshoot: 1.1 }
		}
		Behavior on height {
			NumberAnimation { duration: 500; easing.type: Easing.OutBack; easing.overshoot: 1.1 }
		}

		HoverHandler { id: hover }

		// collapsed: just the clock
		Text {
			id: timeText
			anchors.centerIn: parent
			visible: opacity > 0
			opacity: notch.expanded ? 0 : 1
			text: Qt.formatDateTime(clock.date, "hh:mm")
			color: Theme.fg
			font.family: Theme.font
			font.pixelSize: 15
			font.bold: true
			Behavior on opacity { NumberAnimation { duration: 150 } }
		}

		// expanded: network / volume / bluetooth / battery
		Row {
			id: row
			anchors.centerIn: parent
			spacing: 22
			visible: opacity > 0
			opacity: notch.expanded && notch.panel === "" && !notch.volumeMode ? 1 : 0
			Behavior on opacity { NumberAnimation { duration: 200 } }

			Module {
				icon: Network.icon()
				label: Network.label
				tint: Network.connected ? Theme.blue : Theme.dim
				clickable: true
				onClicked: notch.panel = "network"
			}

			// volume: hovering morphs the whole notch into a slider
			Module {
				id: volModule
				icon: Audio.icon()
				label: Audio.label
				tint: Audio.muted ? Theme.dim : Theme.green
				clickable: true
				onClicked: Audio.toggleMute()
				onHoveredChanged: if (hovered) notch.volumeMode = true
			}

			Module {
				icon: Bluetooth.icon()
				label: Bluetooth.label
				tint: Bluetooth.powered ? Theme.green : Theme.dim
				clickable: true
				onClicked: notch.panel = "bluetooth"
			}

			Module {
				icon: Battery.icon()
				label: Battery.label
				tint: Battery.charging ? Theme.green
					: Battery.percent < 20 ? Theme.red : Theme.fg
			}

			// power profile mode setter
			Module {
				icon: Battery.profileIcon()
				tint: Battery.profile === "power-saver" ? Theme.green
					: Battery.profile === "performance" ? Theme.red : Theme.yellow
				clickable: true
				onClicked: Battery.cycleProfile()
			}

			Module {
				icon: "󰸉"
				tint: Theme.aqua
				clickable: true
				onClicked: notch.panel = "wallpaper"
			}
		}

		// volume slider consuming the whole notch
		Item {
			id: volOverlay
			anchors.fill: parent
			anchors.leftMargin: 24
			anchors.rightMargin: 24
			visible: opacity > 0
			opacity: notch.volumeMode ? 1 : 0
			Behavior on opacity { NumberAnimation { duration: 200 } }

			Text {
				id: volIcon
				anchors.left: parent.left
				anchors.verticalCenter: parent.verticalCenter
				text: Audio.icon()
				color: Audio.muted ? Theme.dim : Theme.green
				font.family: Theme.font
				font.pixelSize: 16

				MouseArea {
					anchors.fill: parent
					anchors.margins: -4
					cursorShape: Qt.PointingHandCursor
					onClicked: Audio.toggleMute()
				}
			}

			Text {
				id: volPct
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				text: Math.round(Audio.volume * 100) + "%"
				color: Theme.label
				font.family: Theme.font
				font.pixelSize: 13
			}

			Item {
				anchors.left: volIcon.right
				anchors.right: volPct.left
				anchors.leftMargin: 12
				anchors.rightMargin: 12
				height: parent.height

				Rectangle {
					id: volTrack
					anchors.verticalCenter: parent.verticalCenter
					width: parent.width
					height: 5
					radius: 3
					color: Theme.dim

					Rectangle {
						width: volTrack.width * Math.min(1, Audio.volume)
						height: parent.height
						radius: 3
						color: Audio.muted ? Theme.dim : Theme.green
					}
				}

				Rectangle {
					x: Math.max(0, volTrack.width * Math.min(1, Audio.volume) - 5)
					anchors.verticalCenter: parent.verticalCenter
					width: 10
					height: 10
					radius: 5
					color: Theme.fg
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onPressed: mouse => Audio.setVolume(mouse.x / width)
					onPositionChanged: mouse => {
						if (pressed) Audio.setVolume(mouse.x / width);
					}
				}
			}
		}

		// panel morphed out of the notch itself
		Column {
			id: panelCol
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.margins: 16
			spacing: 12
			visible: opacity > 0
			opacity: notch.panel !== "" ? 1 : 0
			Behavior on opacity { NumberAnimation { duration: 200 } }

			// back button header
			Item {
				width: parent.width
				height: 22

				Row {
					anchors.left: parent.left
					anchors.verticalCenter: parent.verticalCenter
					spacing: 10

					Text {
						anchors.verticalCenter: parent.verticalCenter
						text: "󰁍"
						color: Theme.dim
						font.family: Theme.font
						font.pixelSize: 15
					}
					Text {
						anchors.verticalCenter: parent.verticalCenter
						text: notch.panel === "network" ? "Network"
							: notch.panel === "bluetooth" ? "Bluetooth" : "Wallpaper"
						color: Theme.fg
						font.family: Theme.font
						font.pixelSize: 13
						font.bold: true
					}
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: notch.panel = ""
				}
			}

			Loader {
				id: loader
				width: parent.width
				active: notch.panel !== ""
				sourceComponent: notch.panel === "network" ? netPanel
					: notch.panel === "bluetooth" ? btPanel
					: notch.panel === "wallpaper" ? wallPanel : null
			}

			Component { id: netPanel; NetworkPanel {} }
			Component { id: btPanel; BluetoothPanel {} }
			Component { id: wallPanel; WallpaperPanel {} }
		}
	}
}
