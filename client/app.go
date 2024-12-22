package main

import (
	"fmt"
	_ "github.com/lib/pq"
	"log"
)

func main() {
	e, err := connect()
	defer e.DB.Close()

	if err != nil {
		log.Fatal(err)
	}

	err = e.DB.Ping()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Successfully connected!")

	values, err := e.iterate(noteViewName)
	if err != nil {
		log.Fatal(err)
	}

	for _, row := range values {
		for _, cell := range row {
			fmt.Printf("%s | ", cell)
		}
		fmt.Println()
	}
}
