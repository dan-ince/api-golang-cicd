# Start with the official Go image for your version
FROM golang:1.21.1-alpine AS build-env

# Set the working directory inside the container
WORKDIR /api-golang-cicd

# Copy the Go module files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code into the container
COPY . ./

# Build the Go app
RUN go build -o myapi

# Start a new stage from Alpine Linux
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /api-golang-cicd

# Copy the binary from the build stage
COPY --from=build-env /api-golang-cicd/myapi ./

# Command to run the executable
CMD ["./myapi"]


