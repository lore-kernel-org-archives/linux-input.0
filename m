From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] Input: gpio_keys - Use of_property_read_u32
Date: Tue, 20 Sep 2011 11:26:27 +1000
Message-ID: <20110920112627.41b180e05dc6717beee0f5e8@canb.auug.org.au>
References: <1314775945-6822-1-git-send-email-tklauser@distanz.ch>
	<1316423391-20219-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__20_Sep_2011_11_26_27_+1000_zhGYxxizcibti0Jh"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from calzone.tip.net.au ([203.10.76.15]:42007 "EHLO
	calzone.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1ITB0c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 21:26:32 -0400
In-Reply-To: <1316423391-20219-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--Signature=_Tue__20_Sep_2011_11_26_27_+1000_zhGYxxizcibti0Jh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tobias,

On Mon, 19 Sep 2011 11:09:51 +0200 Tobias Klauser <tklauser@distanz.ch> wro=
te:
>
> Use the of_property_read_u32 helper function to retreive u32 values
> from the device tree. Also do not pass the len parameter to
> of_get_property if it isn't checked afterwards.
>=20
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> v2: Fix build failure caused by a missing opening brace (reported by
>     Stephen Rothwell)

Sure, but it will still generate all the warnings I reported as "reg" is
the wrong type now.

drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_get_devtree_pdat=
a':
drivers/input/keyboard/gpio_keys.c:500:3: warning: passing argument 3 of 'o=
f_property_read_u32' from incompatible pointer type
include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type '=
const u32 **'
drivers/input/keyboard/gpio_keys.c:504:19: warning: assignment makes intege=
r from pointer without a cast
drivers/input/keyboard/gpio_keys.c:508:3: warning: passing argument 3 of 'o=
f_property_read_u32' from incompatible pointer type
include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type '=
const u32 **'
drivers/input/keyboard/gpio_keys.c:509:20: warning: assignment makes intege=
r from pointer without a cast
drivers/input/keyboard/gpio_keys.c:515:3: warning: passing argument 3 of 'o=
f_property_read_u32' from incompatible pointer type
include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type '=
const u32 **'
drivers/input/keyboard/gpio_keys.c:516:33: warning: assignment makes intege=
r from pointer without a cast

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__20_Sep_2011_11_26_27_+1000_zhGYxxizcibti0Jh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOd+vDAAoJEDMEi1NhKgbs9WAH/igkPtbMjTsHkBP4HWi+s7xG
Afw1gFQbYx4h3uwiBTvWzxLdJKu5U9TvH+2C3kRGcmZfQqhdXc11OiHhfc+3EpDM
n94EkN4e13yjDg6hP7nlZqvCQmHYRRtMT3MfOUku+VnG3IJuUzsfnc3G4cUF0sZM
tJHNG35CY1wK2uHuWcUYTtBDU8c3IzJzlHxr6On5xFxUUt8OKgWQjxmbnrz+ZUy+
MwdiY/MRWR+PUaN5C8NZMsk2xUt77Z3PKHgxshwzsfQD0cCmKT/7Vq03YhM+2gdB
g7kspA1DbtpgLep9u9nAodOECcPuiFgAgRsjKNe1z7HhSv+TUW0gXfDgOQiVG5w=
=kj5C
-----END PGP SIGNATURE-----

--Signature=_Tue__20_Sep_2011_11_26_27_+1000_zhGYxxizcibti0Jh--
