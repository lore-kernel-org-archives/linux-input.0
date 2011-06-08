From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCHv4 1/3] sony_ff_hid_descriptor
Date: Wed, 8 Jun 2011 09:45:23 +0200
Message-ID: <20110608094523.c7232556.ospite@studenti.unina.it>
References: <1307179957-24458-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Jun_2011_09_45_23_+0200_Vpzg/rSywJnD5wiS"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:59357 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab1FHHpj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Jun 2011 03:45:39 -0400
In-Reply-To: <1307179957-24458-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Marcin Tolysz <tolysz@gmail.com>

--Signature=_Wed__8_Jun_2011_09_45_23_+0200_Vpzg/rSywJnD5wiS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat,  4 Jun 2011 02:32:35 -0700
Simon Wood <simon@mungewell.org> wrote:

> This patch modifies the HID descriptor of the Sixaxis controller
> to allow the reporting of the accelerometers and gyro via
> a joystick axis.
>=20
> rewrite section from offset 148

=46rom offset 83? Below I see rdesc[83] =3D=3D 0x75

> --
> 0x75, 0x08,         /*          Report Size (8),            */
> 0x95, 0x27,         /*          Report Count (39),          */ /* all the=
 other data
> lumped together */

I'd keep commit messages wrapped to 72/80 chars as well if possible.

[...]
> @@ -43,6 +49,11 @@ static __u8 *sony_report_fixup(struct hid_device *hdev=
, __u8 *rdesc,
>  		hid_info(hdev, "Fixing up Sony Vaio VGX report descriptor\n");
>  		rdesc[55] =3D 0x06;
>  	}
> +	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) &&
> +			*rsize =3D=3D 148 && rdesc[83] =3D=3D 0x75) {
> +		hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
> +		memcpy((void *)&rdesc[83], (void *) &sixaxis_rdesc_fixup, sizeof(sixax=
is_rdesc_fixup));
> +	}
>  	return rdesc;
>  }
> =20

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__8_Jun_2011_09_45_23_+0200_Vpzg/rSywJnD5wiS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3vKJQACgkQ5xr2akVTsAE3GACfZ9QAoMgTkLH7kwAy50y7TShl
xnsAnA/nO45oIhloSaV6SzClycP/I6p/
=adkr
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Jun_2011_09_45_23_+0200_Vpzg/rSywJnD5wiS--
