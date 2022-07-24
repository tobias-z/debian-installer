# debian-installer

Installation of my own debian system

## Installation

From the root folder run:

```bash
# If you get source is not found error run 'dpkg-reconfigure dash' and select no when asked
sh bin/install.sh
```

### Arguments

- (-e|--email) $EMAIL_NAME
- (-f|--setup-folder-structure)
- (-g|--setup-git)

Example:

```bash
sh bin/install.sh --setup-folder-structure
```
