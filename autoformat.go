package main

import (
	"fmt"
	"os"
	"os/exec"
)

func init() {}

func main() {
	args := os.Args[1:]
	if len(args) != 2 {
		fmt.Fprintln(os.Stderr, "Invalid parameters, please specify a language and version")
		os.Exit(1)
	}
	switch args[0] {
	case "csharp":
		DotnetFormat()
		break
	default:
		fmt.Fprintln(os.Stderr, "Invalid language provided")
		os.Exit(1)
	}
}

func RunCmd(name string, args ...string) {
	cmd := exec.Command(name, args...)
	stdout, err := cmd.Output()
	if err != nil {
		fmt.Fprintln(os.Stderr, err.Error())
		os.Exit(1)
	}
	fmt.Println(string(stdout))
}

func DotnetFormat() {
	RunCmd("dotnet", "format")
}
