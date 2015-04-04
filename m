From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: atkbd: Fix release quirk for Dell models
Date: Sun, 5 Apr 2015 00:48:44 +0200
Message-ID: <201504050048.44878@pali>
References: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1534641.QtOAzAQ6QM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35287 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbbDDWss (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Apr 2015 18:48:48 -0400
In-Reply-To: <1427639779-27377-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1534641.QtOAzAQ6QM
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 29 March 2015 16:36:19 Pali Roh=C3=A1r wrote:
> This patch fixes commit 61579ba83934 ("Input: atkbd - expand
> Latitude's force release quirk to other Dells"). Before that
> commit release quirks were called for all Dell Latitude
> models. After that commit only for Portable Dell devices. But
> lot of Latitude models are Laptop or Notebook DMI devices so
> quirks are not called.
>=20
> Release quirks are still needed also for new Dell Latitude
> models, so this patch enables quirks for all Portable,
> Laptop, Notebook and Sub-Notebook Dell devices.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Dmitry, Matthew: Can be this patch pushed to 4.0 and backported=20
to stable releases? It fix regression caused by specified commit.=20
I tested this patch on Latitude E6440 and now all keys are=20
correctly released.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1534641.QtOAzAQ6QM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUgakwACgkQi/DJPQPkQ1KnhQCfcMh5xDpevCCn1QqCATBJLV/8
IbkAoJM/66ozL/eeqolGB3vq0kgpBBzC
=vzf7
-----END PGP SIGNATURE-----

--nextPart1534641.QtOAzAQ6QM--
