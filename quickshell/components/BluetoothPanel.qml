import QtQuick
import ".."
import "../services"

Column {
	spacing: 10

	// paired devices plus discovered ones not yet paired
	readonly property var allDevices: Bluetooth.devices.concat(
		Bluetooth.discovered
			.filter(d => !Bluetooth.devices.some(p => p.mac === d.mac))
			.map(d => ({ mac: d.mac, name: d.name, connected: false, isNew: true })))

	Item {
		width: parent.width
		height: 24

		Text {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			text: "Power"
			color: Theme.fg
			font.family: Theme.font
			font.pixelSize: 14
			font.bold: true
		}

		Toggle {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			checked: Bluetooth.powered
			onToggled: c => Bluetooth.setPower(c)
		}
	}

	Rectangle {
		width: parent.width
		height: 1
		color: Theme.dim
		opacity: 0.4
	}

	Item {
		width: parent.width
		height: 22
		visible: Bluetooth.powered

		Text {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			text: Bluetooth.discovering ? "scanning…"
				: allDevices.length === 0 ? "no devices" : "devices"
			color: Theme.dim
			font.family: Theme.font
			font.pixelSize: 11
		}

		Rectangle {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			width: scanText.implicitWidth + 18
			height: 20
			radius: 8
			color: Bluetooth.discovering ? Theme.dim : Theme.purple
			opacity: Bluetooth.discovering ? 0.5 : 1

			Text {
				id: scanText
				anchors.centerIn: parent
				text: "scan"
				color: Theme.bg
				font.family: Theme.font
				font.pixelSize: 11
				font.bold: true
			}

			MouseArea {
				anchors.fill: parent
				enabled: !Bluetooth.discovering
				cursorShape: Qt.PointingHandCursor
				onClicked: Bluetooth.startScan()
			}
		}
	}

	ListView {
		width: parent.width
		height: Math.min(contentHeight, 220)
		clip: true
		visible: Bluetooth.powered
		model: allDevices

		delegate: Item {
			id: row
			required property var modelData
			width: ListView.view.width
			height: 30

			Row {
				anchors.left: parent.left
				anchors.verticalCenter: parent.verticalCenter
				spacing: 8

				Text {
					anchors.verticalCenter: parent.verticalCenter
					text: row.modelData.isNew ? "󰂰"
						: row.modelData.connected ? "󰂱" : "󰂯"
					color: row.modelData.connected ? Theme.purple
						: row.modelData.isNew ? Theme.dim : Theme.label
					font.family: Theme.font
					font.pixelSize: 14
				}
				Text {
					anchors.verticalCenter: parent.verticalCenter
					text: row.modelData.name
					color: row.modelData.connected ? Theme.purple : Theme.label
					font.family: Theme.font
					font.pixelSize: 13
				}
			}

			Text {
				anchors.right: parent.right
				anchors.verticalCenter: parent.verticalCenter
				text: row.modelData.isNew ? "tap to pair"
					: row.modelData.connected ? "connected" : "tap to connect"
				color: row.modelData.connected ? Theme.green : Theme.dim
				font.family: Theme.font
				font.pixelSize: 11
			}

			MouseArea {
				anchors.fill: parent
				cursorShape: Qt.PointingHandCursor
				onClicked: {
					if (row.modelData.isNew)
						Bluetooth.pairAndConnect(row.modelData.mac);
					else
						Bluetooth.toggleDevice(row.modelData.mac, row.modelData.connected);
				}
			}
		}
	}
}
