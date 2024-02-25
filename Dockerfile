FROM golang:1.22

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum main.go handlers ./
RUN go mod download && go mod verify
RUN mkdir handlers
RUN mv login_handler.go handlers
RUN mv saludo_handler.go handlers
RUN mv verificacion_handler.go handlers

RUN go build -o main .

# Especifica el comando que se ejecutará cuando se inicie el contenedor
CMD ["./main"]
