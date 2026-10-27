#!/usr/bin/env/ python3

num1 = int(input("Enter number 1: "))
num2 = int(input("Enter number 2: "))
mod = input("Enter modifier: ")

if mod == "+":
    result = num1 + num2
elif mod == "-":
    result = num1 - num2
elif mod == "*":
    result = num1 * num2
elif mod == "/":
    result = num1 / num2
print(mod)
print(result)
