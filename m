From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Input: appletouch - driver refactoring
Date: Sun, 12 Oct 2008 16:54:49 +0200
Message-ID: <1223823289.10176.9.camel@johannes.berg>
References: <1223542147.6130.14.camel@galileo>
	 <20081011032120.GB22499@anvil.corenet.prv>
	 <1223822468.9733.1.camel@galileo>  <1223822674.9733.5.camel@galileo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EEUh6jqMVyKLFlJl5kmK"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:56066 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbYJLOyz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Oct 2008 10:54:55 -0400
In-Reply-To: <1223822674.9733.5.camel@galileo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


--=-EEUh6jqMVyKLFlJl5kmK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-10-12 at 16:44 +0200, Stelian Pop wrote:
> The appletouch driver has grown up from supporting only a couple of
> touchpads into supporting many touchpads, which can have different
> number of sensors, different aspect ratios etc.
>=20
> This patch cleans up the current driver code and makes it easy to
> support the features of each different touchpad.
>=20
> As a side effect, this patch also modifies the 'Y' multiplication factor
> of the 'geyser3' and 'geyser4' touchpads (found on Core Duo and Core2
> Duo MacBook and MacBook Pro laptops) in order to make the touchpad
> output match the aspect ratio of the touchpad (Y factor changed from 43
> to 64).

Looks nice, will give it a test later, just a small comment.


> +static struct atp_info fountain_info =3D {
> +	.type		=3D ATP_FOUNTAIN,

> +static struct atp_info geyser1_info =3D {
> +	.type		=3D ATP_GEYSER1,

> +static struct atp_info geyser2_info =3D {
> +	.type		=3D ATP_GEYSER2,

> +static struct atp_info geyser3_info =3D {
> +	.type		=3D ATP_GEYSER3,

> +static struct atp_info geyser4_info =3D {
> +	.type		=3D ATP_GEYSER4,

Those have all different types.

>  	/* reorder the sensors values */
> -	if (dev->type =3D=3D ATP_GEYSER2) {
> +	if (dev->info->type =3D=3D ATP_GEYSER2) {

> +				if (dev->info->type =3D=3D ATP_GEYSER2)
> +					dev->info->xsensors =3D 20;

> -	if (dev->type !=3D ATP_FOUNTAIN) {
> +	if (dev->info->type !=3D ATP_FOUNTAIN) {

And there are only three uses. Do we expect to add new uses of the
types, especially different structs that share the type? Otherwise I'd
suggest to use

if (dev->info =3D=3D &geyser2_info) and &fountain_info respectively and jus=
t
remove the type thing completely.

johannes

--=-EEUh6jqMVyKLFlJl5kmK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI8g+2AAoJEKVg1VMiehFYqxQQAKcdbe0ESTdn1p2cJuS50KO/
VOds6rf8B9+2KJnkx6UMrlQa/a11GvcwkYOnG63k5iOZckLeCcJ5R5LJ/XNaZiHi
Ht4rSJyGD8stHa/1dArXPphP608mcNaMp1Fs+SG0MD1CxavklDTCH/550zcOzHYf
6tl6eiVfIOCBXFcAVLu0lSyrSCl1EkVa9r/ApXPpjDZMIvzbRMtZdbuMugg+71u1
KSTXLNK6FBOcfD87IvIyzmdjEEvw3/kGXbF3z8ZVfzmEiTrLyr0zq4IFrnlHAw8S
lMaHKZyypy1uDHuAFS2iXVofbrrb1gWeZAvUBjClApFhrNzvB1yewooO7P+UKdq4
pG5Zgb3KqyCXkI1yt7kiTR0V64YPlt3X10/bJnh4BIA5naVvsooHtvzVtZOYfLau
NJJVWuKw2WPVeQ1z4NPrzRGhLsURY/ldNNPlh04NbPUPWyf/SBysN1dACCWRt5rh
BDQYKMpkfvE1+36PNss5M4IhRzc9QhhX9zSBBJwwT7o7c7MIeCZgICp35p5dK2Pr
0aTQRgYL0aAbeQCelaN6xtENRzJd1GFOrvkSZ6+qg3QaV4qSU/+AditAaEEsP1Z7
5gCGEzYv9R33mXKXa6M8X/zrjTVhdD2Vb99BIt3kjZBe2XS3ilrUVL3XAuM7M2EW
axpeYDG5dcDi3sdAtM0d
=1DXr
-----END PGP SIGNATURE-----

--=-EEUh6jqMVyKLFlJl5kmK--

