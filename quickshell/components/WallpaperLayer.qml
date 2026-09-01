import Quickshell
import Quickshell.Wayland
import QtQuick
import "../services"

PanelWindow {
	id: win

	property var modelData
	screen: modelData

	WlrLayershell.layer: WlrLayer.Background
	WlrLayershell.namespace: "wallpaper"
	exclusionMode: ExclusionMode.Ignore
	anchors {
		top: true
		bottom: true
		left: true
		right: true
	}
	color: "black"

	property Image front: img1

	function swapTo(img) {
		if (front === img) return;
		front.opacity = 0;
		img.opacity = 1;
		front = img;
	}

	function show(path) {
		if (path === "") return;
		const back = front === img1 ? img2 : img1;
		if (back.source == "file://" + path && back.status === Image.Ready) {
			swapTo(back);
			return;
		}
		back.source = "file://" + path;
	}

	Connections {
		target: Wallpaper
		function onCurrentChanged() { win.show(Wallpaper.current); }
	}

	Component.onCompleted: show(Wallpaper.current)

	Image {
		id: img1
		anchors.fill: parent
		fillMode: Image.PreserveAspectCrop
		asynchronous: true
		cache: false
		opacity: 0
		Behavior on opacity { NumberAnimation { duration: 400 } }
		onStatusChanged: if (status === Image.Ready) win.swapTo(img1)
	}

	Image {
		id: img2
		anchors.fill: parent
		fillMode: Image.PreserveAspectCrop
		asynchronous: true
		cache: false
		opacity: 0
		Behavior on opacity { NumberAnimation { duration: 400 } }
		onStatusChanged: if (status === Image.Ready) win.swapTo(img2)
	}
}
