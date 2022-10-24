#!/bin/bash
# Copyright (C) 2021  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC

source $(dirname "$0")/common.sh
set -e
enable_vivado 2017.2

INSTALL_DIR=$1

source env/conda/bin/activate fpga-interchange

pushd build
make install
popd
cp environment.yml $INSTALL_DIR
mkdir -p $INSTALL_DIR/techmaps
cp tests/common/libs/*.v $INSTALL_DIR/techmaps

du -ah $INSTALL_DIR
export GIT_HASH=$(git rev-parse --short HEAD)
tar -I "pixz" -cvf interchange-techmaps-${GIT_HASH}.tar.xz -C $INSTALL_DIR techmaps
for device in $(ls $INSTALL_DIR/devices)
do
    tar -I "pixz" -cvf interchange-$device-${GIT_HASH}.tar.xz -C $INSTALL_DIR/devices $device
done
