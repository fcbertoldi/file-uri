# file-uri

`file-uri` is a shell script that converts input paths into [file URIs](https://en.wikipedia.org/wiki/File_URI_scheme).

Some terminal emulators, such as alacritty, support clickable URI links. You can use `file-uri` f.ex. in a script or shell one-liner to output a file path with the `file://` scheme where you can open in the web browser.

## Examples

Converting a relative path:
```
$ mkdir /tmp/foo && cd /tmp/foo
$ file-uri a
file:///tmp/foo/a
``` 

Multiple params:
```
$ file-uri a b c
file:///tmp/foo/a
file:///tmp/foo/b
file:///tmp/foo/c
```


Converting absolute paths:
```
$ file-uri /usr/bin
file:///usr/bin
```

Percent-encodes reserved URI ASCII characters:
```
$ file-uri "with whitespace"
file:///tmp/foo/with%20whitespace
```

Handling stdin:
```
$ touch c d e
$ ls | file-uri
file:///tmp/foo/c
file:///tmp/foo/d
file:///tmp/foo/e
```

Passing the computer host as param:
```
$ file-uri -n localhost a
file://localhost/tmp/a
```

## Usage

```
Usage:
  file-uri [-z | --no-hostname] [-n <hostname> | --host=<hostname>] [-t] <path>...
  file-uri [-z | --no-hostname] [-n <hostname> | --host=<hostname>] [-t] [-]
  file-uri -h | --help

Options:
  -z --no-hostname      do not output hostname prefix (file:/path).
  -n --host=<hostname>  use <hostname> in the host part
  -t                    do not output the trailing newline

Arguments:
  <path>  file path
```

