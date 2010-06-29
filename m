From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 2/4] Input: ad7879 - split bus logic out
Date: Tue, 29 Jun 2010 02:08:42 -0400
Message-ID: <201006290208.44097.vapier@gentoo.org>
References: <20100625081847.8617.31150.stgit@localhost.localdomain> <20100625082224.8617.52942.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2109669.R7DSD1bhL3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33746 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab0F2GJg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 02:09:36 -0400
In-Reply-To: <20100625082224.8617.52942.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

--nextPart2109669.R7DSD1bhL3
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday, June 25, 2010 04:22:24 Dmitry Torokhov wrote:
> From: Mike Frysinger <vapier@gentoo.org>
>=20
> The ad7879 driver is using the old bus method of only supporting one at a
> time (I2C or SPI).  So refactor it like the other input drivers that
> support multiple busses simultaneously.
>=20
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>=20
>  drivers/input/touchscreen/ad7879-i2c.c |  140 +++++++++
>  drivers/input/touchscreen/ad7879-spi.c |  190 ++++++++++++
>  drivers/input/touchscreen/ad7879.c     |  495
> +++++++------------------------- drivers/input/touchscreen/ad7879.h     |=
=20
>  30 ++
>  4 files changed, 461 insertions(+), 394 deletions(-)
>  create mode 100644 drivers/input/touchscreen/ad7879-i2c.c
>  create mode 100644 drivers/input/touchscreen/ad7879-spi.c
>  create mode 100644 drivers/input/touchscreen/ad7879.h

i think you forgot the Kconfig and Makefile changes.  without those, the=20
driver cannot be configured/compiled correctly.

i also see you changed the code from passing a struct device pointer to a=20
struct ad7879 pointer.  i went with the struct device because it generated=
=20
smaller code due to pushing down of the dev get/set drvdata.  the i2c struc=
t=20
sucks because it doesnt stick its dev member at the start of the structure.
=2Dmike

--nextPart2109669.R7DSD1bhL3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMKY3sAAoJEEFjO5/oN/WBfosP/22SW9JgMxOhkfyiqbubnMaJ
vUTD8dTUobGlDNi/NVc3M4vTz9PO3eWgrYoUBIX6ryT32Eweeqfh1U90MIIdfVBH
kyTGJxqJ/41oUn+GhC7+N9GkjC9v0iZnK/7X+WoxmdUy6HdPrCnT5SV7WoijZuns
X+Dk+sUxDtAWmUc9uC9qjfoRg4SgZk+HiiSLm5NyXxVxvx9wXTVXlhE5IYU5d4GO
5mFA0JfAa5cK3aoA0KfI2Jdl/1BBQZZqeRe3aSII73/3O6EEDrVuvBmL5QN9eJ93
DO6rtzMv0DTxC0u8qC/GqWyjxCGUiJONOEhVb8YcW3oSUw7G77jhYyi14+YtCloe
uCRjAPL74pd4hsY2Dgtff+Bfvown4kRjqgyo/MS6+l5tsapnoIUyRmjHFOfK1OSk
Zj/S9W7TXQVlCW0vG8exsNvQZwa3Ar5vTkk5jOPfmM8udYC2MVooO/JIRCo55olz
Yc+/nGCE0R+D9AV99a9GZXI7EOvVh0ENYc4X6q81R1AXftE/eqgmv1szsuMAQaiN
KKECNY4xIxKMWs634ttWG+YD88fVcGJDHtlDEGGpx3nJIF6Y+CfSu+xHXv3ppNJy
/4UhyNsLRxqY057kiwY5D6AcCyLDB1hesCoV4P+4kHekJN+/b5IS35eWuPZCOXVn
TzDNYrcBW3zWYxNUZf+a
=Hbb9
-----END PGP SIGNATURE-----

--nextPart2109669.R7DSD1bhL3--
