package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"
)

// ConsentEvent represents a single consent log
type ConsentEvent struct {
	UserID        string          `json:"userId"`
	DeviceID      string          `json:"deviceId,omitempty"`
	PolicyVersion string          `json:"policyVersion"`
	Categories    map[string]bool `json:"categories"`
	Region        string          `json:"region"`
	Timestamp     time.Time       `json:"timestamp"`
}

// Handler for consent logs
func consentHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var event ConsentEvent
	if err := json.NewDecoder(r.Body).Decode(&event); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}
	if event.UserID == "" || event.PolicyVersion == "" {
		http.Error(w, "Missing required fields", http.StatusBadRequest)
		return
	}

	// Ensure timestamp is set
	if event.Timestamp.IsZero() {
		event.Timestamp = time.Now().UTC()
	}

	// Structured log output (stdout)
	logData, _ := json.Marshal(event)
	log.Println(string(logData))

	w.WriteHeader(http.StatusCreated)
	w.Write([]byte(`{"status":"ok"}`))
}

func main() {
	http.HandleFunc("/consent", consentHandler)
	log.Println("Consent API running on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
