pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
	readonly property var sink: Pipewire.defaultAudioSink
	readonly property real volume: sink?.audio?.volume ?? 0
	readonly property bool muted: sink?.audio?.muted ?? true

	readonly property string label: muted ? "" : Math.round(volume * 100) + "%"

	PwObjectTracker { objects: [Pipewire.defaultAudioSink] }

	function setVolume(v) {
		if (sink?.audio)
			sink.audio.volume = Math.max(0, Math.min(1, v));
	}

	function toggleMute() {
		if (sink?.audio)
			sink.audio.muted = !sink.audio.muted;
	}

	function icon() {
		if (muted || volume === 0) return "󰝟";
		if (volume > 0.6) return "󰕾";
		if (volume > 0.3) return "󰖀";
		return "󰕿";
	}
}
