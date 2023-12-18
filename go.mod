module github.com/veritone/engines/engines/aiware/transcode/meta-llama-batch-batch

go 1.21

replace go-llama.cpp => ./go-llama.cpp

require (
	github.com/veritone/engines/pkg/aion v1.2.0
	github.com/veritone/engines/pkg/engine v1.6.2
	go-llama.cpp v0.0.0-20231009155254-aeba71ee8428
)

require (
	github.com/gabriel-vasile/mimetype v1.4.1 // indirect
	github.com/go-skynet/go-llama.cpp v0.0.0-20231009155254-aeba71ee8428 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.16 // indirect
	github.com/rs/zerolog v1.28.0 // indirect
	github.com/santhosh-tekuri/jsonschema/v5 v5.1.1 // indirect
	github.com/veritone/engines/pkg/coreapi v1.0.0 // indirect
	golang.org/x/net v0.14.0 // indirect
	golang.org/x/sys v0.12.0 // indirect
	gopkg.in/square/go-jose.v2 v2.6.0 // indirect
	gopkg.in/vansante/go-ffprobe.v2 v2.1.1 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
)
