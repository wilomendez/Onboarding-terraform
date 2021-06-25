package main

import (
	"dummy-app/handlers"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	log.Println("Creating Handler")
	h := new(handlers.DummyHandler)
	log.Println("Start exec...")
	lambda.Start(h.Greet)
}
