import QtQuick
import ".."
import "../services"

Column {
	id: panel

	// ssid currently showing a password prompt
	property string passwordFor: ""

	spacing: 10

	Item {
		width: parent.width
		height: 24

		Text {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			text: "Wi-Fi"
			color: Theme.fg
			font.family: Theme.font
			font.pixelSize: 14
			font.bold: true
		}

		Text {
			anchors.right: wifiToggle.left
			anchors.rightMargin: 10
			anchors.verticalCenter: parent.verticalCenter
			visible: Network.scanning
			text: "scanning…"
			color: Theme.dim
			font.family: Theme.font
			font.pixelSize: 11
		}

		Toggle {
			id: wifiToggle
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			checked: Network.wifiEnabled
			onToggled: c => Network.setWifi(c)
		}
	}

	Item {
		width: parent.width
		height: 24

		Text {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			text: "Ethernet"
			color: Theme.fg
			font.family: Theme.font
			font.pixelSize: 14
			font.bold: true
		}

		Text {
			anchors.right: ethToggle.left
			anchors.rightMargin: 10
			anchors.verticalCenter: parent.verticalCenter
			text: Network.ethDevice !== "" ? Network.ethDevice : "none"
			color: Theme.dim
			font.family: Theme.font
			font.pixelSize: 11
		}

		Toggle {
			id: ethToggle
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			checked: Network.ethConnected
			onToggled: Network.toggleEthernet()
		}
	}

	Rectangle {
		width: parent.width
		height: 1
		color: Theme.dim
		opacity: 0.4
	}

	ListView {
		width: parent.width
		height: Math.min(contentHeight, 220)
		clip: true
		visible: Network.wifiEnabled
		model: Network.networks

		delegate: Column {
			id: row
			required property var modelData
			width: ListView.view.width

			Item {
				width: parent.width
				height: 30

				Row {
					anchors.left: parent.left
					anchors.verticalCenter: parent.verticalCenter
					spacing: 8

					Text {
						anchors.verticalCenter: parent.verticalCenter
						text: Network.strengthIcon(row.modelData.strength)
						color: row.modelData.inUse ? Theme.blue : Theme.label
						font.family: Theme.font
						font.pixelSize: 14
					}
					Text {
						anchors.verticalCenter: parent.verticalCenter
						text: row.modelData.ssid
						color: row.modelData.inUse ? Theme.blue : Theme.label
						font.family: Theme.font
						font.pixelSize: 13
					}
					Text {
						anchors.verticalCenter: parent.verticalCenter
						visible: row.modelData.secured
						text: "󰌾"
						color: Theme.dim
						font.family: Theme.font
						font.pixelSize: 12
					}
				}

				Text {
					anchors.right: parent.right
					anchors.verticalCenter: parent.verticalCenter
					visible: row.modelData.inUse
					text: "󰄬"
					color: Theme.green
					font.family: Theme.font
					font.pixelSize: 13
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: {
						if (row.modelData.inUse) return;
						if (row.modelData.secured && !row.modelData.known)
							panel.passwordFor = panel.passwordFor === row.modelData.ssid
								? "" : row.modelData.ssid;
						else
							Network.connectTo(row.modelData.ssid, "");
					}
				}
			}

			Item {
				visible: panel.passwordFor === row.modelData.ssid
				width: parent.width
				height: visible ? 32 : 0

				Rectangle {
					anchors.left: parent.left
					anchors.right: connectBtn.left
					anchors.rightMargin: 8
					anchors.verticalCenter: parent.verticalCenter
					height: 26
					radius: 8
					color: "transparent"
					border.color: Theme.dim
					border.width: 1

					TextInput {
						id: pwInput
						anchors.fill: parent
						anchors.leftMargin: 10
						anchors.rightMargin: 10
						verticalAlignment: TextInput.AlignVCenter
						echoMode: TextInput.Password
						color: Theme.fg
						font.family: Theme.font
						font.pixelSize: 12
						clip: true
						onAccepted: {
							Network.connectTo(row.modelData.ssid, text);
							panel.passwordFor = "";
						}
					}
				}

				Rectangle {
					id: connectBtn
					anchors.right: parent.right
					anchors.verticalCenter: parent.verticalCenter
					width: connectText.implicitWidth + 20
					height: 26
					radius: 8
					color: Theme.blue

					Text {
						id: connectText
						anchors.centerIn: parent
						text: "connect"
						color: Theme.bg
						font.family: Theme.font
						font.pixelSize: 12
						font.bold: true
					}

					MouseArea {
						anchors.fill: parent
						cursorShape: Qt.PointingHandCursor
						onClicked: {
							Network.connectTo(row.modelData.ssid, pwInput.text);
							panel.passwordFor = "";
						}
					}
				}
			}
		}
	}
}
