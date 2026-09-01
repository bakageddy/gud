import QtQuick
import ".."

Rectangle {
	id: toggle

	property bool checked: false
	signal toggled(bool checked)

	width: 36
	height: 20
	radius: 10
	color: checked ? Theme.green : Theme.dim

	Behavior on color { ColorAnimation { duration: 150 } }

	Rectangle {
		width: 14
		height: 14
		radius: 7
		y: 3
		x: toggle.checked ? toggle.width - 17 : 3
		color: Theme.bg
		Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
	}

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		onClicked: toggle.toggled(!toggle.checked)
	}
}
