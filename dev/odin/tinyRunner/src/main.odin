package main

import "core:fmt"
import "core:os"
import rl "vendor:raylib"

mainHeight: i32 = 400
mainWidth: i32 = 300

main :: proc() {
	rl.InitWindow(mainWidth, mainHeight, "Runner")
	defer (rl.CloseWindow())

	calcArg := []string{"tinyCalc"}

	calcProcDesc := os.Process_Desc {
		command = calcArg,
	}

	calcRec := rl.Rectangle {
		width  = 100,
		height = 50,
		x      = 50,
		y      = 50,
	}

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		rl.SetExitKey(.Q)

		if rl.GuiButton(calcRec, "TinyCalc") {
			_, testErr := os.process_start(calcProcDesc)
			if testErr != nil do fmt.panicf("FAIL: %v", testErr)
			os.exit(0)
		}
		rl.EndDrawing()

	}
}
