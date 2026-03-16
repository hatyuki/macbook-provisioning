#!/usr/bin/env zsh
# has_command returns true if $1 as a shell command exists
(( $+commands[${1:?too few argument}] ))
return $status
