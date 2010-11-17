From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 1/2] HID: add support for force feedback in
 'Thrustmaster F430 Force Feedback' steering wheel
Date: Wed, 17 Nov 2010 09:56:50 +0100
Message-ID: <20101117095650.1c2210e1.ospite@studenti.unina.it>
References: <AANLkTimwZwG208QuBYaF7kXmeedcvUZ6iGwjNjJBOOMn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__17_Nov_2010_09_56_50_+0100_WADY0MF0CG2zvo+2"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:38237 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759790Ab0KQI5F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 03:57:05 -0500
In-Reply-To: <AANLkTimwZwG208QuBYaF7kXmeedcvUZ6iGwjNjJBOOMn@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Orefice <aorefice77@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Wed__17_Nov_2010_09_56_50_+0100_WADY0MF0CG2zvo+2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Nov 2010 09:41:17 +0100
Antonio Orefice <aorefice77@gmail.com> wrote:

Hi Antonio, have I heard of you from unina?

>=20
> --- hid-tmff.c-2.6.35	2010-11-16 13:54:29.563224822 +0100
> +++ hid-tmff.c	2010-11-16 13:46:42.549871515 +0100
> @@ -251,8 +252,12 @@
>  		.driver_data =3D (unsigned long)ff_rumble },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651),	/* FGT Rumble
> Force Wheel */
>  		.driver_data =3D (unsigned long)ff_rumble },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654),	/* FGT Force
> Feedback Wheel */
>  		.driver_data =3D (unsigned long)ff_joystick },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a),	/* F430 Force
> Feedback */
> +		.driver_data =3D (unsigned long)ff_joystick },
>  	{ }
>  };

Patch looks space damaged, check your email client settings. Why don't
you try using git (or at least quilt) instead of manual diffing? Tools
are there for a reason :)

Also, I really think the two patches can be folded into one, the commit
messages are telling us so.

Regards,
   Antonio Ospite

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__17_Nov_2010_09_56_50_+0100_WADY0MF0CG2zvo+2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzjmNIACgkQ5xr2akVTsAFf8gCglyRiLSJ94B39j3uXsNpPz02G
Jr8AoJPE2Jyh/bTLnVP6JtJUoEy54H1j
=1K85
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Nov_2010_09_56_50_+0100_WADY0MF0CG2zvo+2--
