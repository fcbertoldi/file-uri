  $ PATH="$TESTDIR:$PATH"

  $ temp_regular=/tmp/regular
  $ touch "$temp_regular"

  $ file-uri "$temp_regular"
  file:///tmp/regular

  $ file-uri -z "$temp_regular"
  file:/tmp/regular

  $ file-uri -n localhost "$temp_regular"
  file://localhost/tmp/regular

  $ temp_whitespace="/tmp/with whitespace"
  $ touch "$temp_whitespace"

  $ file-uri "$temp_whitespace"
  file:///tmp/with%20whitespace
