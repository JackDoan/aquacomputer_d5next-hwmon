# Maintainer: Anthony Wang <ta180m at protonmail dot com>
# Contributor: Yiyao Yu <yuydevel at protonmail dot com>
# Contributor: Benjamin Maisonnas <ben at wainei dot net>
# Author: Ondrej Čerman

_pkgname=aquacomputer
pkgname=aquacomputer-dkms
pkgver=5.17.0
pkgrel=rc6-develop
pkgdesc='hwmon driver for Aquacomputer devices (D5 Next, etc)'
arch=('any')
url='https://github.com/JackDoan/aquacomputer_d5next-hwmon'
license=('GPL2')
depends=('dkms')
provides=('aquacomputer')
conflicts=('aquacomputer')

source=("$_pkgname-$pkgver.tar.gz::https://github.com/JackDoan/$_pkgname/archive/refs/tags/v$pkgver-$pkgrel.tar.gz")
sha256sums=('SKIP')

prepare() {
  sed -e "s/@CFLGS@//" \
      -e "s/@VERSION@/$pkgver/" \
      -i "$srcdir/$_pkgname-$pkgver/dkms.conf"
}

package() {
  install -Dm644 "$srcdir/$_pkgname-$pkgver/dkms.conf" "$pkgdir/usr/src/$_pkgname-$pkgver/dkms.conf"
  install -Dm644 "$srcdir/$_pkgname-$pkgver/Makefile" "$pkgdir/usr/src/$_pkgname-$pkgver/Makefile"
  install -Dm644 "$srcdir/$_pkgname-$pkgver/aquacomputer_d5next.c" "$pkgdir/usr/src/$_pkgname-$pkgver/aquacomputer_d5next.c"

  install -Dm644 "$srcdir/$_pkgname.conf" "$pkgdir/usr/lib/modprobe.d/$_pkgname.conf"
}

# vim:set et ts=2 sw=2 tw=79