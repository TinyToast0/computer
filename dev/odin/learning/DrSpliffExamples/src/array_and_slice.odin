// array_and_slice.odin
package main

import "core:fmt"

// Note, this proc takes a ptr to an array (of type [10]int), this is because we want the array to already
// exist when we call this proc, and we want to modify it's (existing) values

Init_Array :: proc(a: ^[10]int, multiplier: int) {
	// Proc arguments are immutable, meaning if we want to modify the values inside the proc, we have
	// to create a copy of them (or, pass a pointer to a pre-existing variable outside the scope of the proc)
	// Useful for validation, in this case, avoiding being able to accidentally set multiplier to anything <= 0
	mult := multiplier
	if mult <= 0 do mult = 1

	// Loop through n times (in this case, 10). Where i = n
	for i in 0 ..< len(a) {
		// On the first loop, this is the same as: a[0] = 0 * mult
		// On the second: a[1] = 1 * mult
		// ...
		a[i] = i * mult
	}

	fmt.println(a^)
}

/*
   Example of using a slice of an array. Specifically, to check for a given number, within a specified range.
   Uses index bounds checking/clamping so that if range_end < range_start, we error, elsewise, if either 
   aforementioned values are invalid, we reset them to the sane default (range_start = 0, range_end = len(array) - 1)
*/
Has_Number_In_Pos_Range :: proc(array: ^[10]int, range_start, range_end, number: int) -> bool {

	if range_end < range_start do fmt.panicf("Invalid range given")

	fmt.printfln("Looking for %d 👀", number)

	// Index Bounds Checking
	length := len(array)

	rs := range_start
	if rs < 0 || rs >= length {
		rs = 0
	}

	re := range_end
	if re < 0 || re >= length {
		re = length - 1
	}

	// Creating a slice of the input array, using the specified range
	slice := array^[rs:re]

	// Notice, when these print, the memory addresses are identical.
	// The slice literally points to the original memory, its not a copy,
	// its a viewport into the memory. We don't have to copy the array at all to
	// do this, as we can simply check the pointer, with the specified offset && length
	fmt.printfln("EXAMPLE: Array Address %p", array)
	fmt.printfln("EXAMPLE: Slice Address %p", slice)


	// Example usage of searching for a given number within the given range. Note, we are
	// looping the slice, but again, as the above address print displays, the slice is looking
	// at the original memory, the array, that we passed into this proc as a ptr


	// this ind variable is just to make the print a bit clearer, if you experiment calling this function
	// with varying arguments
	ind := rs
	for num in slice {
		fmt.printfln("TEST: RANGE [%d, %d] = (%d) %d", rs, re, ind, num)
		ind = ind + 1
		if num == number do return true
	}
	return false
}
