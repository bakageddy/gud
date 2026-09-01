import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
	id: win

	property var modelData
	screen: modelData

	property int radius: 16

	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.namespace: "screen-corners"
	exclusionMode: ExclusionMode.Ignore
	anchors {
		top: true
		bottom: true
		left: true
		right: true
	}
	color: "transparent"

	// empty region: fully click-through
	mask: Region {}

	component Corner: Canvas {
		width: win.radius
		height: win.radius
		onPaint: {
			const ctx = getContext("2d");
			ctx.reset();
			ctx.fillStyle = "black";
			ctx.beginPath();
			// top-left inverse corner; instances rotate into place
			ctx.moveTo(0, 0);
			ctx.lineTo(width, 0);
			ctx.arc(width, height, width, -Math.PI / 2, Math.PI, true);
			ctx.lineTo(0, 0);
			ctx.closePath();
			ctx.fill();
		}
	}

	Corner { anchors.top: parent.top; anchors.left: parent.left }
	Corner { anchors.top: parent.top; anchors.right: parent.right; rotation: 90 }
	Corner { anchors.bottom: parent.bottom; anchors.right: parent.right; rotation: 180 }
	Corner { anchors.bottom: parent.bottom; anchors.left: parent.left; rotation: 270 }
}
