# slackin

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with slackin](#setup)
    * [What slackin affects](#what-slackin-affects)
    * [Setup requirements](#setup-requirements)
 4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This is a module for running [slackin](https://github.com/rauchg/slackin). It defines a resource
that allows you to run multiple slackin instances at a time.

You'll need to provide your own nodejs package and install slackin to '/opt/slackin'.

This module is currently only tested on EL7.

## Setup

### What slackin affects

It adds:

* One user per instance
* One script in `/usr/local/bin/` per instance
* `/etc/systemd/system/slackin@.service`
* One instantiation of the above systemd service per instance

### Setup Requirements

* Nodejs
* slackin installed to `/opt/slackin/bin/slackin`

## Limitations

* Requires systemd
* Only tested on EL7
