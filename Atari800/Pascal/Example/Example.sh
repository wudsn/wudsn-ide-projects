#!/bin/bash

tools=~/jac/wudsn/Tools
mads=$tools/ASM/MADS/mads.macos-x86-64
mp=$tools/PAS/MP/mp.macos-x86-64
lib=$mp/lib
base=$mp/base

set -e

$mp Example.pas -ipath:$lib
$mads Example.a65 -x -i:$base -o:Example.xex
open Example.xex