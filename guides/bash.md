# Bash

In addition to [shell](/shell/) best practices:


### Scoping

1. In functions, use `local` before every variable declaration.
1. Use `UPPERCASE_VARS` to indicate environment variables that can be controlled outside your script.
1. Use `__double_underscore_prefixed_vars` to indicate global variables that are solely controlled inside your script, with the exception of arguments that are already prefixed with `arg_`, as well as functions, over which b3bp poses no restrictions.

### Coding style

1. Use two spaces for tabs, do not use tab characters.
1. Do not introduce whitespace at the end of lines or on blank lines as they obfuscate version control diffs.
1. Use long options (`logger --priority` vs `logger -p`). If you are on the CLI, abbreviations make sense for efficiency. Nevertheless, when you are writing reusable scripts, a few extra keystrokes will pay off in readability and avoid ventures into man pages in the future, either by you or your collaborators. Similarly, we prefer `set -o nounset` over `set -u`.
1. Use a single equal sign when checking `if [[ "${NAME}" = "davit" ]]`; double or triple signs are not needed.
1. - Prefer `[[` over `test` or `[`. Use the new bash builtin test operator (`[[ ... ]]`) rather than the old single square bracket test operator or explicit call to `test`.
1. Prefer `${var,,}` and `${var^^}` over `tr` for changing case.
1. Prefer `${var//from/to}` over `sed` for simple string replacements.
1. Prefer process substitution over a pipe in `while read` loops.
1. Use `((` or `let`, not `$((` when you don't need the result

### Safety and Portability

1. Use `{}` to enclose your variables. Otherwise, Bash will try to access the `$ENVIRONMENT_app` variable in `/srv/$ENVIRONMENT_app`, whereas you probably intended `/srv/${ENVIRONMENT}_app`. Since it is easy to miss cases like this, we recommend that you make enclosing a habit.
1. Use `set`, rather than relying on a shebang like `#!/usr/bin/env bash -e`, since that is neutralized when someone runs your script as `bash yourscript.sh`.
1. Use `#!/usr/bin/env bash`, as it is more portable than `#!/bin/bash`.
1. Use `${BASH_SOURCE[0]}` if you refer to current file, even if it is sourced by a parent script. In other cases, use `${0}`.
1. Use `:-` if you want to test variables that could be undeclared. For instance, with `if [ "${NAME:-}" = "Kevin" ]`, `$NAME` will evaluate to `Kevin` if the variable is empty. The variable itself will remain unchanged. The syntax to assign a default value is `${NAME:=Kevin}`.

### Function packaging

It is nice to have a Bash package that can not only be used in the terminal, but also invoked as a command line function. In order to achieve this, the exporting of your functionality *should* follow this pattern:

```bash
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
  export -f my_script
else
  my_script "${@}"
  exit $?
fi
```
This allows a user to `source` your script or invoke it as a script.

```bash
# Running as a script
$ ./my_script.sh some args --blah
# Sourcing the script
$ source my_script.sh
$ my_script some more args --blah
```


