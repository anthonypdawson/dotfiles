#!/bin/bash
# --- cdots.sh -------------------------------------------------------
# Change directory back - 1-7 times - and forth with TAB-completion.
# For TAB-completion see: cdots-completion.sh
# Copyright (C) 2007-2008  Freddy Vulto
# Version: cdots-1.2.1
# Usage: .. [dir]
#        ... [dir]
#        .... [dir]
#        ..... [dir]
#        ...... [dir]
#        ....... [dir]
#        ........ [dir]
#
# Arguments: [dir]   Directory to go forth - down the directory tree
#
# Example:   $/usr/local/share> ... sh[TAB]
#            $/usr/share>
#
# INSTALLATION
#
# Installing this file is only necessary when you want to install cdots and 
# bash completion separate; install cdots-completion.sh as well.
#
# See also INSTALL file.
# 
# Copy cdots-function.sh to your home directory:
# 
#     cp cdots-function.sh ~/
# 
# Add this line to your ~/.bashrc file:
#    
#     . ~/cdots-function.sh
#
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software 
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
# MA 02110-1301, USA
#
# The latest version of this software can be obtained here:
# http://www.fvue.nl/cdots/


#--- cdots() ---------------------------------------------------------
# Change directory to specified directories back, and forth
# @param $1 string   Directory back
# @param $2 string   Directory forth
# @see _cdots() for TAB-completion
function cdots() {
    # If dir can't be found, try globbing with `eval'
    [ -d "$1$2" ] && cd "$1$2" || eval cd "$1$2"
} # cdots()


    # Define aliases .. ... .... etc
    # NOTE: Functions are not defined directly as .. ... .... etc, 
    #       because these are not valid identifiers under `POSIX'
cdotsAlias=.; cdotsDepth=7; cdotsDir=
while ((cdotsDepth--)); do
    cdotsAlias=$cdotsAlias.; cdotsDir=$cdotsDir../
    alias $cdotsAlias="cdots $cdotsDir"
done
unset -v cdotsDepth cdotsAlias cdotsDir
