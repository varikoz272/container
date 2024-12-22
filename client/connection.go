package main

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	// "log"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "admin-nahren"
	password = "admin"
	dbname   = "everything"
)

// Connects to database. Connection should be closed
func connect() (Everything, error) {
	return NewEverything(host, user, password, dbname, port)
}

type Everything struct {
	*sql.DB
}

func NewEverything(host, user, password, dbname string, port int) (Everything, error) {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)

	var e Everything
	db, err := sql.Open("postgres", psqlInfo)
	e.DB = db

	return e, err
}

func (e Everything) iterator(v View) (*sql.Rows, error) {
	query := fmt.Sprintf("SELECT * FROM %s", v.name)
	return e.DB.Query(query)
}

type View struct {
	name    string
	columns []string
}

var (
	noteViewName = View{
		name:    "text_note_view",
		columns: []string{"name", "color", "body"},
	}
)

func (e Everything) iterate(v View) ([][]string, error) {
	var rows [][]string

	rowIterator, err := e.iterator(v)
	defer rowIterator.Close()
	if err != nil {
		return nil, err
	}

	for rowIterator.Next() {
		columns := make([][]byte, len(noteViewName.columns))

		if len(columns) == 3 {
			if err := rowIterator.Scan(&columns[0], &columns[1], &columns[2]); err != nil {
				return nil, err
			}
			rows = append(rows, []string{string(columns[0]), string(columns[1]), string(columns[2])})
		}
	}

	return rows, nil

}
