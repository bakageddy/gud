pragma Singleton
import Quickshell
import QtQuick

Singleton {
	property string name: "gruvbox"

	readonly property var palettes: ({
		gruvbox: {
			bg: "#1d2021",
			fg: "#ebdbb2",
			label: "#d5c4a1",
			dim: "#665c54",
			blue: "#83a598",
			green: "#b8bb26",
			purple: "#d3869b",
			aqua: "#8ec07c",
			yellow: "#fabd2f",
			red: "#fb4934"
		},
		oxocarbon: {
			bg: "#161616",
			fg: "#f2f4f8",
			label: "#dde1e6",
			dim: "#525252",
			blue: "#78a9ff",
			green: "#42be65",
			purple: "#be95ff",
			aqua: "#3ddbd9",
			yellow: "#f1c21b",
			red: "#fa4d56"
		}
	})

	readonly property color bg: palettes[name].bg
	readonly property color fg: palettes[name].fg
	readonly property color label: palettes[name].label
	readonly property color dim: palettes[name].dim
	readonly property color blue: palettes[name].blue
	readonly property color green: palettes[name].green
	readonly property color purple: palettes[name].purple
	readonly property color aqua: palettes[name].aqua
	readonly property color yellow: palettes[name].yellow
	readonly property color red: palettes[name].red

	readonly property string font: "JetBrainsMono Nerd Font"
}
