package main

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"log"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "admin-nahren"
	password = "admin"
	dbname   = "everything"
)

func main() {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Successfully connected!")

	rows, err := db.Query("SELECT * FROM text_note_view;")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var name string
		var color string
		var body string
		if err := rows.Scan(&name, &color, &body); err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s | %s | %s\n", name, color, body)
	}
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

}
