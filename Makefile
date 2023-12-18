# ID of this engine (used for identification and tagging)
ENGINE_ID = f3ef00bf-ab2a-48fa-bf36-d9a5e36a221d

# Human name of this engine (used for documentation)
ENGINE_NAME = Meta LLaMa Batch

# Relative path from github project root to this directory
MY_DIR = engines/aiware/transcode/meta-llama-batch-batch

# Root of engine monorepo
ROOT_DIR = ../../../../

# Include base makefile that all engines use (configured by the above config options)
# Generally speaking this should cover the needed make targets for 99% of engines that live
# inside the monorepo, but in the case that it doesn't, you can add your own targets, to expand the default targets.

include $(ROOT_DIR)base/Engine.mk


# How to expand this makefile in various ways leveraging features of the base makefile:
#
# ======================================================================
#
# 	How to expand with additional targets:
#
# 	clean::
# 		echo "This will run before the default clean, while still running the default clean"
#
# 	include $(ROOT_DIR)base/Engine.mk
#
# 	clean::
# 		echo "This will run after the default clean runs"
#
# 	custom-target:
# 		echo "This is a target custom only to this engine"
#
# ======================================================================
#
# 	If you need Additional build arguments to pass to the docker build command
# 	that can be accomplished by defining an ENGINE_BUILD_ARGS variable
# 	before including the base makefile.
#
# 	define ENGINE_BUILD_ARGS
# 	--build-arg FOO=BAR \
# 	--env KEY=VAL \
# 	--build-arg ENHANCED=false
# 	endef
#
# 	include $(ROOT_DIR)base/Engine.mk
#
# ======================================================================
#
#		If you need to change the exposed ports when running local testing,
#		for example if your engine does not run on the default port of 8080,
#		you can define the DOCKER_PORTS variable before including the base makefile:
#
#		DOCKER_PORTS = -p 9090:9090 -p 8081:8081
#
#		include $(ROOT_DIR)base/Engine.mk
#
# ======================================================================
#
# If simply "extending" the default targets does not fit your use case,
# You can just copy the content of /base/Engine.mk here and modify it.
# We should avoid this if at all possible.
