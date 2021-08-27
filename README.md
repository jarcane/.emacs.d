# .emacs.d

A basic Emacs config, primarily built around working with Clojure and Lisps.
This has only been tested under Linux/WSL2, specifically Ubuntu 20.04, but other distros should work.

## Prerequisites

### Package security

For the package security to work, you will need to make sure that GnuTLS is installed. This is `gnutls-bin` on
Ubuntu, or `gnutls` on Arch/Manjaro.

You will also need to install the certificates, for which you'll need Python and Pip, and do this:

```
python -m pip install --user certifi
```

For more info on the package security setup, see: <https://glyph.twistedmatrix.com/2015/11/editor-malware.html>

### Code font

The default font is Fira Code, which you can install via package on most distros.
See here: <https://github.com/tonsky/FiraCode/wiki/Installing>