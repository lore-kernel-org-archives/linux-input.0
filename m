From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: Preferred way for a multitouch driver?
Date: Sun, 11 Apr 2010 15:02:33 -0400
Message-ID: <4BC21CC9.40606@seas.upenn.edu>
References: <Pine.LNX.4.64.1004111828030.29274@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:51187 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab0DKTDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 15:03:07 -0400
In-Reply-To: <Pine.LNX.4.64.1004111828030.29274@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, Michael Poole <mdpoole@troilus.org>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/11/10 12:41, Florian Echtler wrote:
> Hello everyone,
>=20
> I've just bought a Lenovo S10-3t convertible netbook, and now I'm
> experimenting with the "multitouch" screen (dual-touch, rather). It's
> being recognized as a HID device, and using hid-device-dump, I can
> nicely read the reports of both fingers. There's also some hacks
> floating around which use xf86-input-hidtouch, but AFAICT that doesn'=
t
> do any kind of multitouch.
>=20
> From lurking here on the list, I've gathered that the evdev interface=
 by
> now fully supports all kinds of multitouch events, so I guess the
> preferred way would be a hiddev-to-evdev bridge of some kind, right?
>=20
> Can somebody point me into the right direction, e.g. to some other
> driver which also works that way?
>=20
> Many thanks,
> Florian

I think St=E9phane is working on that one.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkvCHMUACgkQwuRiAT9o609ckACgkDYjvF4SN67jn1A1/+DttvF+
xpkAnA2FFlfc6e6UhP7YkTJda4IaOjRY
=3DRr6m
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
