package main

import "core:fmt"
import "core:slice"

param :: struct {
	content: string,
	tag:     string,
	alias:   []string,
}

paramType :: enum {
	none,
	title,
	body,
	appname,
	time,
	urgency,
}

// Allocates param struct and returns pointer
paramCreate :: proc() -> ^param {
	p, err := new(param)
	if err != nil do fmt.panicf("Could not allocate Param: %v", err)
	return p
}

// Deallocates param struct by passed pointer
paramDestroy :: proc(p: ^param) {
	delete_slice(p.alias)
	free(p)
}

// Deallocate all param structs inside given array
paramClear :: proc(paramArray: ^[dynamic]^param) {
	for i in 0 ..< len(paramArray) {
		paramDestroy(paramArray[i])
	}
}

paramGetWithTag :: proc(params: ^[dynamic]^param, tag: string) -> ^param {
	for i in 0 ..< len(params) {
		if params[i].tag == tag {
			return params[i]
		}
	}
	return nil
}

paramMatch :: proc(params: ^[dynamic]^param, input: string) -> (expected: paramType, index: int) {
	for i in 0 ..< len(params) {
		for alias in params[i].alias {
			if input == alias {
				switch (params[i].tag) {
				case "appname":
					return .appname, i

				case "time":
					return .time, i

				case "urgency":
					return .urgency, i

				case:
					return .none, i
				}
			}
		}
	}
	return nil, -1
}

// Initialise all param structs and update given array
paramInit :: proc(paramArray: ^[dynamic]^param) {
	pTitle := paramCreate()
	pTitle.tag = "title"
	append(paramArray, pTitle)

	pBody := paramCreate()
	pBody.tag = "body"
	append(paramArray, pBody)

	pAppname := paramCreate()
	pAppname.tag = "appname"
	pAppname.alias = slice.clone([]string{"-a", "--appname"})
	append(paramArray, pAppname)

	pTime := paramCreate()
	pTime.tag = "time"
	pTime.alias = slice.clone([]string{"-t", "--time"})
	append(paramArray, pTime)

	pUrgency := paramCreate()
	pUrgency.tag = "urgency"
	pUrgency.alias = slice.clone([]string{"-u", "--urgency"})
	append(paramArray, pUrgency)
}
