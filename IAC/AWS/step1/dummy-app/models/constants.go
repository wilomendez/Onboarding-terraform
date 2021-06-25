package models

type Message struct {
	Text string `json:"message"`
}

const (
	helloworld string = "Hello World"
)

var (
	HelloMessage Message = Message{
		Text: helloworld,
	}
)
