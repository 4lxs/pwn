package main

import (
	"fmt"
	"os"
	"strings"
)

var flag = "irisctf{this_is_not_the_real_flag}"

// func init() {
// 	runed := []string{}
// 	z := rune(0)
//
// 	for _, v := range flag {
// 		runed = append(runed, string(v+z))
// 		z = v
// 	}
//
// 	flag = strings.Join(runed, "")
// }

func main() {
	file, err := os.OpenFile("the", os.O_RDWR|os.O_CREATE, 0644)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer file.Close()
	buf := make([]byte, 63)
	if _, err = file.Read(buf); err != nil {
		fmt.Println(err)
		return
	}
	z := rune(0)

	unruned := []string{}
	for _, v := range string(buf) {
		ans := v - z
		unruned = append(unruned, string(ans))
		z = ans
	}
	fmt.Println(strings.Join(unruned, ""))
}
