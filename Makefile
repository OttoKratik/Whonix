#!/usr/bin/make -f

## Copyright (C) 2012 - 2014 Patrick Schleizer <adrelanos@riseup.net>
## See the file COPYING for copying conditions.

## genmkfile - Makefile - version 1.6

## This is a copy.
## master location:
## https://github.com/Whonix/genmkfile/blob/master/usr/share/genmkfile/Makefile

.PHONY: about

GENMKFILE_NAME ?= makefile-full
GENMKFILE_BOOTSTRAP_ONE ?= ./packages/genmkfile/usr/share/genmkfile/$(GENMKFILE_NAME)
GENMKFILE_BOOTSTRAP_TWO ?= ./usr/share/genmkfile/$(GENMKFILE_NAME)
GENMKFILE_PATH ?= /usr/share/genmkfile
GENMKFILE_ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
GENMKFILE_CURRENT := $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))

ifndef GENMKFILE_INCLUDE_FILE_MAIN
   ifneq (,$(wildcard $(GENMKFILE_BOOTSTRAP_ONE)))
      GENMKFILE_INCLUDE_FILE_MAIN := $(GENMKFILE_BOOTSTRAP_ONE)
   else ifneq (,$(wildcard $(GENMKFILE_BOOTSTRAP_TWO)))
      GENMKFILE_INCLUDE_FILE_MAIN := $(GENMKFILE_BOOTSTRAP_TWO)
   else
      GENMKFILE_INCLUDE_FILE_MAIN := $(GENMKFILE_PATH)/$(GENMKFILE_NAME)
   endif
endif

export GENMKFILE_NAME
export GENMKFILE_PATH
export GENMKFILE_ROOT_DIR
export GENMKFILE_INCLUDE_FILE_MAIN
export GENMKFILE_CURRENT

about:
	@echo "GENMKFILE_CURRENT: $(GENMKFILE_CURRENT)"

ifdef GENMKFILE_INCLUDE_FILE_PRE
   ifeq (,$(wildcard $(GENMKFILE_INCLUDE_FILE_PRE)))
      $(error GENMKFILE_INCLUDE_FILE_PRE $(GENMKFILE_INCLUDE_FILE_PRE) does not exist!)
   else
      include $(GENMKFILE_INCLUDE_FILE_PRE)
   endif
endif

ifneq ($(GENMKFILE_INCLUDE_FILE_MAIN),0)
   ifeq (,$(wildcard $(GENMKFILE_INCLUDE_FILE_MAIN)))
      $(error GENMKFILE_INCLUDE_FILE_MAIN $(GENMKFILE_INCLUDE_FILE_MAIN) does not exist!)
   else
      include $(GENMKFILE_INCLUDE_FILE_MAIN)
   endif
endif

ifdef GENMKFILE_INCLUDE_FILE_POST
   ifeq (,$(wildcard $(GENMKFILE_INCLUDE_FILE_POST)))
      $(error GENMKFILE_INCLUDE_FILE_POST $(GENMKFILE_INCLUDE_FILE_POST) does not exist!)
   else
      include $(GENMKFILE_INCLUDE_FILE_POST)
   endif
endif
