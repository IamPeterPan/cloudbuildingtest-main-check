# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START cloudrun_helloworld_dockerfile]
# [START run_helloworld_dockerfile]

# Use the offical golang image to create a binary.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.17-alpine3.15 as builder

# Create and change to the app directory.
WORKDIR /build

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
# Expecting to copy go.mod and if present go.sum.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY *.go ./

# Build the binary.
RUN go build -o /main

# Use the official Debian slim image for a lean production container.
# https://hub.docker.com/_/base
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM gcr.io/distroless/base-debian10


# Copy the binary to the production image from the builder stage.
COPY --from=builder /build/main /build/main
# RUN chmod a+x /build/main
EXPOSE 8080
USER nonroot:nonroot
# Run the web service on container startup.
CMD ["/build/main"]

# [END run_helloworld_dockerfile]
# [END cloudrun_helloworld_dockerfile]
