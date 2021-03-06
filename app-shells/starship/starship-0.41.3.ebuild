# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.10
ansi_term-0.11.0
ansi_term-0.12.1
arrayref-0.3.6
arrayvec-0.4.12
arrayvec-0.5.1
attohttpc-0.13.0
atty-0.2.14
autocfg-1.0.0
base64-0.11.0
battery-0.7.5
bitflags-1.2.1
blake2b_simd-0.5.10
block-buffer-0.7.3
block-padding-0.1.5
byte-tools-0.3.1
byte-unit-3.0.3
byteorder-1.3.4
bytes-0.5.4
cc-1.0.53
cfg-if-0.1.9
chrono-0.4.11
clap-2.33.1
constant_time_eq-0.1.5
core-foundation-0.6.4
core-foundation-0.7.0
core-foundation-sys-0.6.2
core-foundation-sys-0.7.0
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.1
crossbeam-utils-0.7.2
digest-0.8.1
dirs-2.0.2
dirs-sys-0.3.4
doc-comment-0.3.3
dtoa-0.4.5
either-1.5.3
env_logger-0.7.1
fake-simd-0.1.2
fnv-1.0.7
foreign-types-0.3.2
foreign-types-shared-0.1.1
generic-array-0.12.3
gethostname-0.2.1
getrandom-0.1.14
git2-0.13.5
hermit-abi-0.1.12
http-0.2.1
humantime-1.3.0
idna-0.2.0
indexmap-1.3.2
itoa-0.4.5
jobserver-0.1.21
lazy_static-1.4.0
lazycell-1.2.1
lexical-core-0.6.7
libc-0.2.70
libgit2-sys-0.12.5+1.0.0
libz-sys-1.0.25
linked-hash-map-0.5.3
log-0.4.8
mach-0.2.3
maplit-1.0.2
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.3.3
memoffset-0.5.4
native-tls-0.2.4
nix-0.15.0
nodrop-0.1.14
nom-5.1.1
ntapi-0.3.4
num-integer-0.1.42
num-traits-0.2.11
num_cpus-1.13.0
once_cell-1.4.0
opaque-debug-0.2.3
open-1.4.0
openssl-0.10.29
openssl-probe-0.1.2
openssl-src-111.9.0+1.1.1g
openssl-sys-0.9.56
os_info-2.0.5
path-slash-0.1.1
percent-encoding-2.1.0
pest-2.1.3
pest_derive-2.1.0
pest_generator-2.1.3
pest_meta-2.1.3
pkg-config-0.3.17
ppv-lite86-0.2.6
pretty_env_logger-0.4.0
proc-macro2-1.0.12
quick-error-1.2.3
quote-1.0.5
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
rayon-1.3.0
rayon-core-1.7.0
redox_syscall-0.1.56
redox_users-0.3.4
regex-1.3.7
regex-syntax-0.6.17
remove_dir_all-0.5.2
rust-argon2-0.7.0
rustc_version-0.2.3
ryu-1.0.4
schannel-0.1.19
scopeguard-1.1.0
security-framework-0.4.4
security-framework-sys-0.4.3
semver-0.9.0
semver-parser-0.7.0
serde-1.0.110
serde_derive-1.0.110
serde_json-1.0.53
serde_urlencoded-0.6.1
sha-1-0.8.2
smallvec-1.4.0
starship_module_config_derive-0.1.1
static_assertions-0.3.4
strsim-0.8.0
syn-1.0.21
sysinfo-0.14.2
tempfile-3.1.0
term_size-0.3.2
termcolor-1.1.0
textwrap-0.11.0
thread_local-1.0.1
time-0.1.43
toml-0.5.6
typenum-1.12.0
ucd-trie-0.1.3
unicode-bidi-0.3.4
unicode-normalization-0.1.12
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
uom-0.26.0
url-2.1.1
urlencoding-1.0.0
vcpkg-0.2.8
vec_map-0.8.2
version_check-0.9.1
void-1.0.2
wasi-0.9.0+wasi-snapshot-preview1
winapi-0.3.8
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
yaml-rust-0.4.3"

inherit cargo

DESCRIPTION="The cross-shell prompt for astronauts"
HOMEPAGE="https://starship.rs"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/starship/starship/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="libressl"

DEPEND="
	libressl? ( dev-libs/libressl:0= )
	!libressl? ( dev-libs/openssl:0= )
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

DOCS="docs/README.md"

src_install() {
	# Can't install as a cargo package,
	# let's do this manually.
	dobin target/release/${PN}
	default
}

pkg_postinst() {
	echo
	elog "Thanks for installing starship."
	elog "For better experience, it's suggested to install some Powerline font."
	elog "You can get some from https://github.com/powerline/fonts"
	echo
}
