package main


import (
    "fmt"
    "net/http"
    "log"
    "os"
    "time"
    "math/rand"
)





func main() {
	log.Print("starting server...")
	http.HandleFunc("/", handler)

	// Determine port for HTTP service.
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("defaulting to port %s", port)
	}

	// Start HTTP server.
	log.Printf("listening on port %s", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal(err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	name := os.Getenv("NAME")
	today := time.Now().Format("15:04:05")
	Time := time.Now().Format("15:04:05")
	if name == "" {

		name = fmt.Sprint("BTC ", rand.Intn(100))
	}
	fmt.Fprintf(w, today,Time , name)
	

}
