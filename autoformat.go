package main

import (
	"fmt"
	"os"
)

func init() {}

func main() {
	args := os.Args[1:]
	fmt.Printf("%v %v", args[0], args[1])
}
