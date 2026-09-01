import QtQuick
import ".."

Item {
	id: mod

	property string icon
	property string label
	property color tint: Theme.fg
	property bool clickable: false
	readonly property bool hovered: hoverHandler.hovered
	signal clicked()

	HoverHandler { id: hoverHandler }

	implicitWidth: inner.implicitWidth
	implicitHeight: inner.implicitHeight

	Row {
		id: inner
		anchors.centerIn: parent
		spacing: 7

		Text {
			anchors.verticalCenter: parent.verticalCenter
			text: mod.icon
			color: mod.tint
			font.family: Theme.font
			font.pixelSize: 16
		}

		Text {
			anchors.verticalCenter: parent.verticalCenter
			visible: text !== ""
			text: mod.label
			color: Theme.label
			font.family: Theme.font
			font.pixelSize: 13
		}
	}

	MouseArea {
		anchors.fill: parent
		enabled: mod.clickable
		cursorShape: Qt.PointingHandCursor
		onClicked: mod.clicked()
	}
}
