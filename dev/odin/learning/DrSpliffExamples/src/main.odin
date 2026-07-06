// main.odin
package main

import "core:fmt"

main :: proc() {
	EXAMPLE_ARRAY: [10]int
	Init_Array(&EXAMPLE_ARRAY, 4)

	ok := Has_Number_In_Pos_Range(&EXAMPLE_ARRAY, 0, 0, 12)
	if ok {
		fmt.println("Found the number! 🫰")
	} else {
		fmt.println("No luck shmuck 😎")
	}
}
