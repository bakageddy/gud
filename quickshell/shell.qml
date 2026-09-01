import Quickshell
import "components"

ShellRoot {
	Variants {
		model: Quickshell.screens
		WallpaperLayer {}
	}

	Variants {
		model: Quickshell.screens
		Notch {}
	}

	Variants {
		model: Quickshell.screens
		ScreenCorners {}
	}
}
