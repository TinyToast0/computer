package main

import "core:strconv"
import rl "vendor:raylib"

main :: proc() {
	input: [dynamic]u8
	defer delete(input)

	rl.InitWindow(600, 100, "Calc")
	defer rl.CloseWindow()
	rl.SetExitKey(.Q)
	doNumber :: proc(expr: string) -> (f64, bool) {
		i := 0
		num: f64 = 0
		current: f64 = 0
		op: u8 = '+'

		parseNumber :: proc(expr: string, i: ^int) -> f64 {
			start := i^

			for i^ < len(expr) {
				c := expr[i^]
				if (c >= '0' && c <= '9') || c == '.' {
					i^ += 1
				} else {
					break
				}
			}

			v, ok := strconv.parse_f64(expr[start:i^])
			if !ok do return 0
			return v
		}

		for i < len(expr) {
			c := expr[i]

			if c == ' ' {
				i += 1
				continue
			}

			if (c >= '0' && c <= '9') || c == '.' {
				current = parseNumber(expr, &i)
				continue
			}

			switch op {
			case '+':
				num += current
			case '-':
				num -= current
			case '*':
				num *= current
			case '/':
				if current == 0 do return 0, false
				num /= current
			}

			op = c
			i += 1
		}

		switch op {
		case '+':
			num += current
		case '-':
			num -= current
		case '*':
			num *= current
		case '/':
			if current == 0 do return 0, false
			num /= current
		}

		return num, true
	}

	// resultF := fmt.ctprintf("%f", result)
	result: f64
	hasResult: bool

	for !rl.WindowShouldClose() {
		for {
			key := rl.GetCharPressed()
			if key == 0 do break

			char := rune(key)
			if (char >= '0' && char <= '9') ||
			   char == '+' ||
			   char == '-' ||
			   char == '*' ||
			   char == '/' {
				append(&input, u8(char))
			}
		}
		if rl.IsKeyDown(.LEFT_CONTROL) && rl.IsKeyPressed(.BACKSPACE) {
			for len(input) > 0 {
				input[len(input) - 1] = 0
				resize(&input, len(input) - 1)
			}
		} else if rl.IsKeyPressed(.BACKSPACE) && len(input) > 0 {
			input[len(input) - 1] = 0
			resize(&input, len(input) - 1)
		}

		if rl.IsKeyPressed(.ENTER) {
			expr := string(input[:])
			value, ok := doNumber(expr)

			if ok {
				result = value
				hasResult = true
			} else {
				hasResult = false
			}
		}

		rl.BeginDrawing()

		// Rectangle drawing
		rl.DrawRectangle(25, 25, 550, 50, rl.ORANGE)
		if len(input) > 0 {
			rl.DrawText(cstring(&input[0]), 25, 25, 30, rl.BLACK)
		}
		if hasResult {
			res := rl.TextFormat("= %.4f", result)

			rl.DrawText(res, 25, 50, 24, rl.RED)
		}

		rl.EndDrawing()
	}

}
