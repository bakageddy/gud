import QtQuick
import ".."

// concave (reverse-radius) corner joining the notch to the screen edge
Canvas {
	id: fillet

	property bool mirrored: false

	width: 7
	height: 7

	onPaint: {
		const ctx = getContext("2d");
		ctx.reset();
		ctx.fillStyle = Theme.bg;
		ctx.beginPath();
		if (mirrored) {
			// right side: curve from the notch wall out to the top edge
			ctx.moveTo(0, 0);
			ctx.lineTo(width, 0);
			ctx.arc(width, height, height, -Math.PI / 2, Math.PI, true);
			ctx.lineTo(0, 0);
		} else {
			// left side
			ctx.moveTo(width, 0);
			ctx.lineTo(0, 0);
			ctx.arc(0, height, height, -Math.PI / 2, 0, false);
			ctx.lineTo(width, 0);
		}
		ctx.closePath();
		ctx.fill();
	}

	Connections {
		target: Theme
		function onBgChanged() { fillet.requestPaint(); }
	}
}
