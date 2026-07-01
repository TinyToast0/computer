package main

import "core:fmt"
import "core:os"

main :: proc() {

	paramArray: [dynamic]^param
	paramExpected: paramType
	defer delete(paramArray)

	paramInit(&paramArray)
	defer paramClear(&paramArray)

	args := os.args[1:]

	for i in 0 ..< len(args) {
		paramExpected, matchAt := paramMatch(&paramArray, args[i])

		#partial switch (paramExpected) {
		case .appname:
			paramArray[matchAt].content = args[i + 1]

		case .time:
			paramArray[matchAt].content = args[i + 1]

		case .urgency:
			paramArray[matchAt].content = args[i + 1]

		case .none:
			switch (len(args[i:])) {
			case 0:
				fmt.eprintln("Requires message")
				os.exit(1)
			case 1:
				pTitle := paramGetWithTag(&paramArray, "title")
				pTitle.content = args[i]
				break
			}
		}
	}

	pTitle := paramGetWithTag(&paramArray, "title")
	if os.is_tty(os.stdin) {
		fmt.println(pTitle.content)
	} else {

		command: [dynamic]string
		defer delete(command)
		append(&command, "notify-send")

		append(&command, "-a")
		defaultAppname := "center-text"
		pAppName := paramGetWithTag(&paramArray, "appname")
		if pAppName.content != "" {
			append(&command, pAppName.content)
		} else {
			append(&command, defaultAppname)
		}

		append(&command, "-u")
		defaultUrgency := "low"
		pUrgency := paramGetWithTag(&paramArray, "urgency")
		if pUrgency.content != "" {
			append(&command, pUrgency.content)
		} else {
			append(&command, defaultUrgency)
		}

		append(&command, "-t")
		defaultTime := "2000"
		pTime := paramGetWithTag(&paramArray, "time")
		if pTime.content != "" {
			append(&command, pTime.content)
		} else {
			append(&command, defaultTime)
		}

		append(&command, pTitle.content)

		pd := new(os.Process_Desc)
		defer free(pd)

		pd.command = command[:]
		_, _, _, _ = os.process_exec(pd^, context.allocator)
	}
}
