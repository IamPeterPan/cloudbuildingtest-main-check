package main


import (
    "encoding/csv"
    "log"
    "os"
)


func main() {
    log.Print("starting server...")
// 	http.HandleFunc("/", handler)

// 	// Determine port for HTTP service.
// 	port := os.Getenv("PORT")
// 	if port == "" {
// 		port = "8080"
// 		log.Printf("defaulting to port %s", port)
// 	} 

    records := [][]string{
        {"date", "time", "currency"},
        {"11/11/2021", "3:00 PM", "BTC 1"},
        {"12/10/2021", "4:00 PM", "BTC 2"},
        {"10/10/2021", "5:00 PM", "BTC 3"},
        {"13/11/2021", "6:00 PM", "BTC 4"},
        {"14/10/2021", "7:00 PM", "BTC 5"},
        {"15/10/2021", "8:00 PM", "BTC 6"},
        
    }

    f, err := os.Create("users.csv")
    defer f.Close()

    if err != nil {

        log.Fatalln("failed to open file", err)
    }

    w := csv.NewWriter(f)
    defer w.Flush()

    for _, record := range records {
        if err := w.Write(record); err != nil {
            log.Fatalln("error writing record to file", err)
        }
    }
}
