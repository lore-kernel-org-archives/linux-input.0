From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/2] Groundwork for Sixaxis paring into bluez.
Date: Wed, 12 May 2010 15:12:35 +0200
Message-ID: <20100512151235.78cd8ed3.ospite@studenti.unina.it>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__12_May_2010_15_12_35_+0200_XXS3CMNDJeuxV/+W"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out20.alice.it ([85.33.2.20]:1635 "EHLO
	smtp-out20.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0ELNNH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 09:13:07 -0400
In-Reply-To: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org

--Signature=_Wed__12_May_2010_15_12_35_+0200_XXS3CMNDJeuxV/+W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon,  3 May 2010 22:15:54 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Hi,
>=20
> These changes are in preparation of seamless integration of the Sixaxis
> pairing procedure into bluez. It was about time :)
>

Ping, and comments below.

> The first one cleans up the quirks handling.
>=20
> The second one adds a sysfs interface to set and get the device and master
> bdaddr, this is needed in order to setup the host for pairing. This kernel
> interface is a mere workaround for the lack of features of hidraw[1], if
> someone wants to add the missing features to hidraw I will be happy to dr=
op
> this one, otherwise consider queuing these for 2.6.35 if it's too late for
> 2.6.34.
>

I guess the silence here was also because this particular
hackish solution must not look very good to you. If there's really a
strong objection to it I might consider extending hidraw capabilities by
adding some ioctls, maybe I just need some extra motivation.

Regards,
   Antonio

> Thanks,
>    Antonio
>=20
> [1] http://www.spinics.net/lists/linux-input/msg08311.html
>=20
>=20
> Antonio Ospite (2):
>   hid/hid-sony: Apply sixaxis quirks only to sixaxis
>   hid/hid-sony: get and set Sixaxis bdaddr via sysfs
>=20
>  drivers/hid/hid-sony.c |  170 ++++++++++++++++++++++++++++++++++++++++++=
+----
>  1 files changed, 155 insertions(+), 15 deletions(-)

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Wed__12_May_2010_15_12_35_+0200_XXS3CMNDJeuxV/+W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvqqUMACgkQ5xr2akVTsAHNhQCdHkVzLtFR2YuJiIvhixF01Svq
BDkAn3DEpYUJQCyUt2jgDqPxALVKk4kO
=hqwX
-----END PGP SIGNATURE-----

--Signature=_Wed__12_May_2010_15_12_35_+0200_XXS3CMNDJeuxV/+W--
