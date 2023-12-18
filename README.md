# Meta Llama Batch

00000000-0000-0000-0000-000000000000

# Purpose

> Define what your engine does. Provide all detail that differentiates it from other engines
> (which may just be the name of the service it uses to do the work).
>
> This should (arguably) be the largest section of this document and should describe what this
> engine will do and all relevant details needed to use the engine:
>
> - does it have biases for or against language, accents, race, proper nouns, etc.?
> - does it have limitations on size, length, language, etc)?
> - what are recommended uses for this engine (use cases)?
> - what are uses for this engine that are not recommended?
> - are there input formats that work better or worse than others?
> - are there performance considerations?
>
> What does your engine output?
>
> - what file formats
> - provide examples of output, especially details of AION files
> - which `validationContracts` does it fulfill?
>   - see https://docs.veritone.com/#/developer/engines/standards/engine-output/?id=engine-output-standard-vtn-standard
> - does it provide bounding boxes? bounding polygons? no bounding info? (visual engines only)
> - does it output words, or phrases? (text engines only)
> - does it output `series` or `objects` or something else?
>
> Note that the lists above are just examples, do not copy this list and answer each question,
> but use the lists as a guide for the types of things that should be documented in this section.

# File Types

> List of Media Types (MIME Types) this engine can process. This list should match the list in
> the engine definition in Developer App

# Parameters

> Document the parameters that your engine takes in the payload field and what they do. This
> information may already be in the "fields" documentation of the engine, but this section
> should
>
> 1. Provide more technical detail than might be appropriate in the public documentation.
>    If there is none, just list the field and say "see field documentation"
> 2. Document any fields that aren't in the public documentation. Such as fields used for
>    tweaking technical behavior (buffer sizes, timeouts, etc), or debugging (verbose flags,
>    logging levels, overrides, etc)

# Testing

> How would I test this engine? This may be as simple as "Run `make install test`", but if there
> are any special accounts or configuration setup needed, define them here. Also document
> other testing options like "Run `make build up-test` and go to http://localhost:9090".

# Development

There are some default targets available during the development of the engine to assist you.

- `make up-test` (and `make up-retest`, which is synonymous to `make build up-test`) which will run your built container locally. Go to http://localhost:9090 to see the engine-toolkit.

- `make up-live` that will run your engine in a container with the same engine-toolkit you get with `up-test`, but
with your code mounted as a volume with a "hot recompile" daemon that will auto restart your code on file save. This is helpful during rapid development, but it's still suggested you do final testing with `make up-test` so you are testing with your actual container that will be deployed.

Its worth noting that `make up-live` is not going to work well for engines that require extra packages installed inside their docker container, as it's a streamlined go specific container.

# Requirements

> Anything we need to know about this engine? Does it require GPU? Does it only run on certain
> hardware? Only in Azure? Require access to other services (database, Redis, etc)?

# References

> Any pointers to external documentation needed to understand this engine.
> Specifically, if this engine uses a 3rd party service like Google, Amazon, Speechmatics, etc.
> this section should contain references to their documentation, contact information, etc
