package handlers

import (
	"context"
	"dummy-app/models"
)

type DummyHandler struct{}

type DummyRepoHandler interface {
	Greet(ctx context.Context)
}

func (dh *DummyHandler) Greet(ctx context.Context) (models.Message, error) {
	return models.HelloMessage, nil
}
