  $ PATH="$TESTDIR:$PATH"
  $ temp_regular=/tmp/regular
  $ temp_whitespace="/tmp/with whitespace"

  $ file-uri "$temp_regular"
  file:///tmp/regular

  $ file-uri -z "$temp_regular"
  file:/tmp/regular

  $ file-uri -n localhost "$temp_regular"
  file://localhost/tmp/regular

  $ file-uri "$temp_whitespace"
  file:///tmp/with%20whitespace

  $ file-uri "$temp_regular" "$temp_whitespace"
  file:///tmp/regular
  file:///tmp/with%20whitespace
