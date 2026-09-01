import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
	anchors.top: true
	// anchors.left: true
	// anchors.right: true
	implicitHeight: 30
	implicitWidth: 700
	color: "#1D2021"

	Text {
		anchors.centerIn: parent
		text: "Hello, Dinesh"
		color: "#FABD2F"
		font.pixelSize: 14
	}
}
