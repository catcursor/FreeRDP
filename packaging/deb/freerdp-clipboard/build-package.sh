#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
	echo "usage: $0 PACKAGE_ROOT OUTPUT_DIRECTORY" >&2
	exit 2
fi

package_root=$1
output_directory=$2
package_version=${PACKAGE_VERSION:?PACKAGE_VERSION must be set}
script_directory=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

if [[ ! $package_version =~ ^[0-9A-Za-z.+:~-]+$ ]]; then
	echo "invalid Debian package version: $package_version" >&2
	exit 2
fi

test -x "$package_root/opt/freerdp-clipboard/bin/xfreerdp3"
install -d "$package_root/DEBIAN" "$package_root/usr/bin" "$output_directory"
ln -sfn /opt/freerdp-clipboard/bin/xfreerdp3 \
	"$package_root/usr/bin/xfreerdp3-clipboard"

installed_size=$(du -sk "$package_root/opt" "$package_root/usr" | awk '{ total += $1 } END { print total }')
sed \
	-e "s/@PACKAGE_VERSION@/$package_version/g" \
	-e "s/@INSTALLED_SIZE@/$installed_size/g" \
	"$script_directory/DEBIAN/control.in" > "$package_root/DEBIAN/control"

package_file="$output_directory/freerdp3-clipboard_${package_version}_amd64.deb"
dpkg-deb --root-owner-group --build "$package_root" "$package_file"
(
	cd "$output_directory"
	sha256sum "$(basename -- "$package_file")" > SHA256SUMS
)
