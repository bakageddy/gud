import QtQuick
import ".."
import "../services"

Column {
	spacing: 10

	Item {
		width: parent.width
		height: 22

		Text {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			text: Wallpaper.files.length === 0
				? "nothing in ~/.config/wallpapers"
				: Wallpaper.files.length + " wallpapers"
			color: Theme.dim
			font.family: Theme.font
			font.pixelSize: 11
		}

		Rectangle {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			width: randomText.implicitWidth + 18
			height: 20
			radius: 8
			color: Theme.blue
			visible: Wallpaper.files.length > 1

			Text {
				id: randomText
				anchors.centerIn: parent
				text: "random"
				color: Theme.bg
				font.family: Theme.font
				font.pixelSize: 11
				font.bold: true
			}

			MouseArea {
				anchors.fill: parent
				cursorShape: Qt.PointingHandCursor
				onClicked: Wallpaper.random()
			}
		}
	}

	GridView {
		id: grid
		width: parent.width
		height: Math.min(Math.ceil(count / 3) * cellHeight, 246)
		clip: true
		cellWidth: Math.floor(width / 3)
		cellHeight: Math.floor(cellWidth * 0.6)
		model: Wallpaper.files

		delegate: Item {
			id: cell
			required property var modelData
			width: grid.cellWidth
			height: grid.cellHeight

			Rectangle {
				anchors.fill: parent
				anchors.margins: 3
				color: "transparent"
				border.width: 2
				border.color: cell.modelData === Wallpaper.current
					? Theme.green : "transparent"

				Image {
					anchors.fill: parent
					anchors.margins: 2
					source: "file://" + cell.modelData
					fillMode: Image.PreserveAspectCrop
					asynchronous: true
					sourceSize.width: 240
					clip: true
				}

				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					onClicked: Wallpaper.set(cell.modelData)
				}
			}
		}
	}
}
