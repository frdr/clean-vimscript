# Clean Vimscript

Yes, you read right: this is *clean vimscript*.
"But isn't vimscript a mess?" you may ask.

# Best Practices

## Use :nnoremap by default

When creating a mapping, use `:nnoremap` unless you explicitly need another command from the `:map` family of commands.

*Rationale:*
In most cases, `:nnoremap` is exactly what you want. It's also minimal in scope and effect. This guards against unwanted mappings.

## Prefer :normal! to :normal

When running normal mode commands from the command line, prefer normal-bang to normal.

*Rationale:*
The bang-form of normal will not execute any mappings on its `{rhs}`, making sure default functionality will be used. This is more robust to mappings providing their own spin on default functionality.

## Make functions abort

When defining a `:function`, follow it with the `abort` argument. This will make the function abort if errors are encountered during its execution.

*Rationale:*
In most cases, it's no use to keep going after a failure.
In the best case, nothing happens, in the worst, garbage is created.
Errors during a function's execution should be anticipated and handled explicitly.
