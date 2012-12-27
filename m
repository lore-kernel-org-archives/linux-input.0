From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] hid-input/battery: add FEATURE quirk
Date: Fri, 28 Dec 2012 00:39:54 +0100
Message-ID: <1356651594.17740.44.camel@deadeye.wl.decadent.org.uk>
References: <1356651338.17740.39.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-YT44KVo6B4hCuQ7uIoXN"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47352 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752267Ab2L0XkF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Dec 2012 18:40:05 -0500
In-Reply-To: <1356651338.17740.39.camel@deadeye.wl.decadent.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org


--=-YT44KVo6B4hCuQ7uIoXN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-12-09 at 00:10 -0800, Jeremy Fitzhardinge wrote:
> Apple keyboards require a FEATURE report to query the battery state,
> even though they list as an input.  Without this, it returns an error.
>=20
> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

I'm looking at cherry-picking this and following commits to 3.2:

652aa6a9ac4a hid-input/battery: add FEATURE quirk
0c47935c5b5c HID: add battery quirk for Apple Wireless ANSI
4cc854178214 HID: add battery quirk for Apple 2009_ISO keyboard

What I don't understand about this is:

[...]
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -283,12 +283,12 @@ static enum power_supply_property hidinput_battery_=
props[] =3D {
>  };
> =20
>  #define HID_BATTERY_QUIRK_PERCENT	(1 << 0) /* always reports percent */
> +#define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
> =20
>  static const struct hid_device_id hid_battery_quirks[] =3D {
> -	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMO=
USE),
> -	  HID_BATTERY_QUIRK_PERCENT },
> -	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTR=
ACKPAD),
> -	  HID_BATTERY_QUIRK_PERCENT },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> +			       USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ANSI),
> +	  HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
>  	{}
>  };
[...]

why did this also remove quirks for two other device IDs?  Are they all
part of the same physical device so that the other two quirks are
redundant?  Or was this a mistake?

Ben.

--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-YT44KVo6B4hCuQ7uIoXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUNzcSue/yOyVhhEJAQoTrRAAn/SVf6ePrnZJ2Ne0bpD1IdlS7xHOkw+G
HY0B1G1q/nlMk17Hk6BfFmD1XvkAxMMQxb/6Dmgj6W0utGPCSbCP7CVHKZNDhDsa
Gk6CyQz+XYk39k+QW8KdRWW14oKL/iFV2KRQ2tWVJ4ng1HnS+qTYMhMjPJdUvwtI
mZbSlFGouJ113Q7SzlIafqFXOvvgx+Jt1/+365HdUPzhOYcYgbgVXQi5lm0UD2Q/
2KmZ3FlGzwBzZrVm58XctwzY/1Yi7tibvnK3eKU8N2A7rz/K+7oPZ5MuVl8gRDON
lEW9l5YiNOh8A6Ntk6WQmOVnJDWqB5aizXQP9p04aMsTCICdWRORwU7Yuka8HRRe
9tdcrBXq1enufxLaSmKyu+QMvWHLGD7XcU9EzQ8svez6xuMVeV4JPOT2nEQk+euR
l9NSNu9jPe1OV2lRyPLwzYeCscQdAHr9flrBG7wFHl8mw7KcN9aSOyZTQaRYu+lS
CJntT4wqhykgREBYeh5BLDXGSBxLrgnS4yo03gBDK7smQIq5RROeyaCg1OaUztPU
sBHoQuK9tiTr5JQsu8lkCT9Kg3NCMAJ8eJ0cl9oQgNXbf5lfbD3fU8xrtFKvS5zH
QPuZGCcWWg43CB9UT4V8Zs6kYL+rFQ2m0R1f0CBqeGgxgODdGz18KUK8ogr84Y1z
t4CjyAlDovM=
=8WFP
-----END PGP SIGNATURE-----

--=-YT44KVo6B4hCuQ7uIoXN--
