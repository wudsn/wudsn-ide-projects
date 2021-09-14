#!/bin/bash

tools=~/jac/wudsn/Tools
mads=$tools/ASM/MADS/mads.macosx-x86-64
mp=$tools/PAS/MP/mp.macosx-x86-64
base=$tools/PAS/base

set -e

$mp Example.pas
$mads Example.a65 -x -i:$base -o:Example.xex
open Example.xex
