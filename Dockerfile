# This is a multi-stage docker file so that we can compile and test in a pristine environment
# that isn't dependent on what version of Go you have installed.
#
# This also allows us to bypass potential issues caused when building containers
# on new arm64 macs -- allowing us to build our binary using our native arch (targeting amd64), but setup
# the container and its dependencies specifically as amd64.

# BUILD stage (uses native archetecture)
FROM --platform=$BUILDPLATFORM golang:1.21 AS build-base

# Verify the build target is amd64 - this is important for running inside AiWARE
# TARGETPLATFORM is passed in our makefile as --platform linux/amd64
# BUILDPLATFORM is a universal variable that defines the platform we are on

ARG TARGETPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
RUN [ "$TARGETPLATFORM" != "linux/amd64" ] && echo "Build must target amd64 to work when deployed. Currently targetting ${TARGETPLATFORM}" && exit 1 || true

# Install required packages needed for the building stage

RUN apt-get update && \
    apt-get --allow-unauthenticated install -y  git tree && \
    go env

# Copy the repo into the docker image
ADD . /go/src/github.com/veritone/engines

# Set gopath
ENV GOPATH /go

# Change working directory and build the engine
WORKDIR /go/src/github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch

# Define C lib path for cpp binding
ENV LD_LIBRARY_PATH /go/src/github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch/go-llama.cpp/libbinding.a:${LD_LIBRARY_PATH}

RUN make compile

# TESTING stage
FROM build-base as test-engine
RUN make test-local

# FINAL stage (this will use the target architecture of amd64)
FROM veritone/aiware-engine-toolkit as engine-toolkit
FROM ubuntu:22.04 as run-engine

# Install any required packages
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Copy required files from previous build stages

COPY --from=engine-toolkit /opt/aiware/engine /opt/aiware/engine
COPY --from=build-base /go/src/github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch/dist/runEngine /app/runEngine
COPY --from=build-base /go/src/github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch/venti /opt/aiware/venti
COPY --from=build-base /go/src/github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch/go-llama.cpp /app/go-llama.cpp
COPY --from=build-base /go/src/github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch/models /app/models

# Run the engine

WORKDIR /app

ARG ENGINE_ID

# There are more ENV variable that might be usefull.
# https://github.com/veritone/realtime/blob/master/modules/constants/envvars.go

ENV ENGINE_ID=${ENGINE_ID}
ENV VERITONE_WEBHOOK_READY="http://0.0.0.0:8080/ready"
ENV VERITONE_WEBHOOK_PROCESS="http://0.0.0.0:8080/process"
ENV AIWARE_LOG_LEVEL="warning"

EXPOSE 8080

ENTRYPOINT ["/opt/aiware/engine","/app/runEngine"]
