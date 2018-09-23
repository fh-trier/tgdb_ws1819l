# UID/GID
# UID or GID is the UNIX user ID or group ID of the user who executes
# make. If the UID or GID is not passed as a make variable, an attempt
# is made to determine it.
UID?=$(shell id --user)
GID?=$(shell id --group)

# VERSION / RELEASE
# If no version is specified as a parameter of make, the last git hash
# value is taken.
VERSION?=$(shell git describe --abbrev=0)+hash.$(shell git rev-parse --short HEAD)
RELEASE?=1

# CONTAINER_RUNTIME / BUILD_IMAGE
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image defined
# by the BUILD_IMAGE variable. The BUILD_IMAGE container serve as build
# environment to execute the different make steps inside. Therefore, the bulid
# environment requires all necessary dependancies to build this project.
CONTAINER_RUNTIME?=$(shell which docker)
BUILD_IMAGE:=volkerraschek/container-latex:latest-ubuntu18.04

# Input tex-file and output pdf-file
FILE_NAME=index
IDX_TARGET:=${FILE_NAME:%=%.idx}
PDF_TARGET:=${FILE_NAME:%=%.pdf}
TEX_TARGET:=${FILE_NAME:%=%.tex}

# HARDLINK_VARIABLES
# FSD:           Defines the general storage location for study documents.
# HARDLINK_PATH: This should be extended with the value from FSD. For example
#                for the subject Mathematics: ${FSD}/Mathematics
# HARDLINK_FILE: Name of the document to be linked under the path HARDLINK_PATH.
FSD?=${HOME}/Dokumente/Studium/Fachschaftsdaten
HARDLINK_PATH:=${FSD}/DB_1_-_Grundlagen_Datenbanken/Tutorien/Tutorium_WS1819
HARDLINK_FILE:=Tutorium_WS1819_-_Loesungen.pdf


# PDF_TARGET
# ==============================================================================
${PDF_TARGET}: latexmk/${PDF_TARGET}


PHONY:=latexmk/${PDF_TARGET}
latexmk/${PDF_TARGET}:
	latexmk \
		-shell-escape \
		-synctex=1 \
		-interaction=nonstopmode \
		-file-line-error \
		-pdf ${TEX_TARGET}

PHONY+=pdflatex/${PDF_TARGET}
pdflatex/${PDF_TARGET}:

	makeglossaries ${FILE_NAME}
	makeindex ${FILE_NAME}

	pdflatex \
		-shell-escape \
		-synctex=1 \
		-interaction=nonstopmode \
		-enable-write18 ${TEX_TARGET}


# CLEAN
# ==============================================================================
PHONY+=clean
clean:
	git clean -fX


# CONTAINER STEPS - PDF_TARGET
# ==============================================================================
container-run/${PDF_TARGET}:
	$(MAKE) container-run COMMAND=$(subst container-run/,,$@)

container-run/latexmk/${PDF_TARGET}:
	$(MAKE) container-run COMMAND=$(subst container-run/,,$@)

container-run/pdflatex/${PDF_TARGET}:
	$(MAKE) container-run COMMAND=$(subst container-run/,,$@)


# CONTAINER STEPS - CLEAN
# ==============================================================================
container-run/clean:
	$(MAKE) container-run COMMAND=$(subst container-run/,,$@)


# GENERAL CONTAINER COMMAND
# ==============================================================================
PHONY+=container-run
container-run:
	${CONTAINER_RUNTIME} run \
		--rm \
		--user ${UID}:${GID} \
		--volume $(shell pwd):/workspace \
			${BUILD_IMAGE} \
				make ${COMMAND} \
					VERSION=${VERSION} \
					RELEASE=${RELEASE}


# HARDLINK
# ==============================================================================
PHONY+=hardlink/create
hardlink/create: hardlink/delete
	if [ ! -d ${HARDLINK_PATH} ]; \
	then \
		mkdir -p ${HARDLINK_PATH}; \
	fi;

	if [ ! -f ${PDF_TARGET} ]; \
	then \
		echo "Compile the PDF file first!"; \
	fi;

	ln ${PDF_TARGET} ${HARDLINK_PATH}/${HARDLINK_FILE}

PHONY+=hardlink/delete
hardlink/delete:
	if [ -f ${HARDLINK_PATH}/${HARDLINK_FILE} ]; \
	then \
		rm -R ${HARDLINK_PATH}/${HARDLINK_FILE}; \
	fi;


# DATABASE-OPERATIONS
# ==============================================================================
db/delete-scheme:
	./sh/delete-schema.sh

db/import-model:
	./sh/import-model.sh

db/execute-solutions:
	./sh/execute-solutions.sh FOLDER=${FOLDER}


# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}
