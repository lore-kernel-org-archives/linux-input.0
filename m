From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Thu, 15 Jan 2015 11:49:32 +0100
Message-ID: <201501151149.32065@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1743017.xQJ6xbQcvs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:55589 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbAOKtf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 05:49:35 -0500
Received: by mail-we0-f178.google.com with SMTP id p10so13879091wes.9
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 02:49:33 -0800 (PST)
In-Reply-To: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

--nextPart1743017.xQJ6xbQcvs
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 January 2015 23:55:48 Dmitry Torokhov wrote:
> Hi Pali,
>=20
> This series try to address the issue you brought regarding
> trackstick initialization on Dell Latitudes in a different
> way than the patches you proposed. Basically in this series
> we move resetting and all detection in alps_detect() and make
> sure we keep the state so alps_init() can reuse it and not
> perform the detection all over again. Doing this allows us to
> set up device characteristics (name, version, etc) properly
> from the get go while still performing reset only once.
>=20
> This is untested as I do not have any ALPS devices anymore so
> I'd appreciate you giving it a spin.
>=20
> Thanks!

Hi Dmitry,

on top of which branch/repository should I apply your patches?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1743017.xQJ6xbQcvs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS3mzwACgkQi/DJPQPkQ1K9awCgqflYYtn1kAZj7qYeHXOL7Bea
+UwAoMO+oOPtt+4nHIXHJy5apUVMBgO7
=Rl93
-----END PGP SIGNATURE-----

--nextPart1743017.xQJ6xbQcvs--
