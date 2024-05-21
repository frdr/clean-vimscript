# Clean Vimscript

A collection of notes on how to write clean and idiomatic vimscript.

This used to be a collection of mental notes.
Until I decided to write them down.

## Best Practices

### Don't touch the system runtime files

User configuration should be in the user directory. This is your `$HOME` and
all your configuration should be in there. The files below `$VIRUNTIME` should
not be touched by the user.

*Rationale:*
Everything in `$VIMRUNTIME` is there for a reason. It controls Vim for *all
users* on the system. Even with only one user, changes in `$VIMRUNTIME` will
usually not be versioned. They will be hard to track, hard to find and create
behavior that cannot be reproduced on other (clean) machines.

### Put vimrc below .vim

User configuration should be in a directory `.vim` or `_vimfiles` below your
`$HOME` directory.  This goes first and foremost for the `vimrc` file.

*Rationale:*
Putting everything-Vim into a directory of its own makes it trivially easy to
use version control on it. Just `git init` in there. You will be able to track
changes and clone your configuration to other machines.

See `:help vimfiles` for places to put the configuration and `:help
xdg-vimrc`for an XDG compliant way to do so.

### Put tweaks in after

Changes from the global default runtime files should be in
`$HOME/.vim/after/<somer_dir>/<some_file>`. 

*Rationale:*
The runtime files in `after` will be sourced *after* the ones in the global
runtime directory. This will allow you to override or tweak global defaults
without losing all of them or changing them.

According to `:help vimfiles':

> In the "after" directory in your home directory.  This is for personal preferences to overrule or add to the distributed defaults or system-wide settings (rarely needed).

The "rarely needed" seems to be a huge understatement.

### Use :nnoremap by default

When creating a mapping, use `:nnoremap` unless you explicitly need another command from the `:map` family of commands.

*Rationale:*
In most cases, `:nnoremap` is exactly what you want. It's also minimal in scope and effect. This guards against unwanted mappings.

### Prefer :normal! to :normal

When running normal mode commands from the command line, prefer normal-bang to normal.

*Rationale:*
The bang-form of normal will not execute any mappings on its `{rhs}`, making sure default functionality will be used. This is more robust to mappings providing their own spin on default functionality.

### Make functions abort

When defining a `:function`, follow it with the `abort` argument. This will make the function abort if errors are encountered during its execution.

*Rationale:*
In most cases, it's no use to keep going after a failure.
In the best case, nothing happens, in the worst, garbage is created.
Errors during a function's execution should be anticipated and handled explicitly.

### Make commands accept bar

When defining a user `:command`, provide the `-bar` option unless there's a
good reason not to.

*Rationale:*
Providing `-bar` will allow commands to be chained using the `|` or `<bar>`
operators. This is what you'd expect from any command. Exceptions are commands
that accept a variable number of arguments.
