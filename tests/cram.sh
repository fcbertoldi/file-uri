#!/usr/bin/env sh

# Usage:
#   cram [OPTIONS] <test-file>
#
# Options:
#   -h --help      Show this help message and exit
#
# Arguments:
#   <test-file>: the test file

usage() {
	script_name=$(basename "$0")
	echo "Usage:"
	echo "  $script_name -h | --help"
	echo ""
	echo "Options:"
	echo "  -h --help      Show this help message and exit."
	echo ""
	echo "Arguments:"
	echo "  <test-file>: the test file"
}

compare_outputs() {
	if ! diff -q "$expected_output_file" "$output_file" > /dev/null; then
		printf "Error: Output differs from expected\n" >&2
		diff -u "$expected_output_file" "$output_file" >&2
		exit 1
	fi
}

exec_cmd() {
	eval "$cmd" > "$output_file"
}

while getopts ":h-" opt; do
	case "$opt" in
	h)
		usage
		exit 0
		;;
	-)
		case "$OPTARG" in
		help)
			usage
			exit 0
			;;
		*)
			echo "Error: Unknown option: --$OPTARG" >&2
			exit 1
			;;
		esac
		;;
	\?)
		echo "Error: Invalid option: -$OPTARG" >&2
		exit 1
		;;
	esac
done

shift "$((OPTIND - 1))"

if [ -z "$1" ]; then
	echo "Test file not provided" >&2
	usage
	exit 1
fi

output_file=$(mktemp)
expected_output_file=$(mktemp)
trap 'rm -f "$output_file" "$expected_output_file"' EXIT INT TERM

cmd_build=''
output_build=''

while IFS= read -r line; do

	if echo "$line" | grep -E '^  \$' >/dev/null; then

		if [ -n "$cmd_build" ]; then
			exec_cmd
		fi

		if [ -n "$output_build" ]; then
			compare_outputs
		fi
		cmd_build=1
		output_build=''
		cmd="${line#  $ }"

	elif echo "$line" | grep -E '^  >' >/dev/null; then

		cmd="$cmd ${line#  > }"

	elif echo "$line" | grep -E '^  ' >/dev/null; then

		if [ -n "$cmd_build" ]; then
			exec_cmd
		fi

		cmd_build=''
		if [ -z "$output_build" ]; then
			echo "${line#  }" >"$expected_output_file"
			output_build=1
		else
			echo "${line#  }" >>"$expected_output_file"
		fi

	else

		if [ -n "$cmd_build" ]; then
			exec_cmd
		fi

		if [ -n "$output_build" ]; then
			compare_outputs
		fi

		cmd_build=''
		output_build=''

	fi

done <"$1"

if [ -n "$cmd_build" ]; then
	exec_cmd
fi

if [ -n "$expected_output" ]; then
	compare_outputs
fi
