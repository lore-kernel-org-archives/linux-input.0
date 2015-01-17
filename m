From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/6] Input: ALPS - fix trackstick detection on some Dell Latitudes
Date: Sat, 17 Jan 2015 11:26:50 +0100
Message-ID: <201501171126.50081@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1617379.v1b9jfCPID";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:37307 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbAQK0x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jan 2015 05:26:53 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so24337564wgg.12
        for <linux-input@vger.kernel.org>; Sat, 17 Jan 2015 02:26:51 -0800 (PST)
In-Reply-To: <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

--nextPart1617379.v1b9jfCPID
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 January 2015 23:55:53 Dmitry Torokhov wrote:
> On some Dell Latitudes we fail to identify presence of
> trackstick unless we reset the device. The issue is quite
> benign as we do perform reset in alps_init(), so the
> trackstick ends up working, but mouse name reported to
> userspace is not accurate.
>=20
> In order to fix the issue while avoiding the additional
> lengthy reset we move the resrt to alps_detect() and keep the
> discovered state to be used later in alps_init().
>=20
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This patch is not enough. ALPS_DUALPOINT flag can be removed also=20
in function alps_hw_init_rushmore_v3() which is called from=20
alps_init() but not from alps_detect(). So this patch does not=20
have to set correct name in alps_detect() based on ALPS_DUALPOINT=20
flag. My original patch set name in alps_init() after hw_init()=20
which handled also this problem...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1617379.v1b9jfCPID
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS6OOoACgkQi/DJPQPkQ1KVkQCeKlHsekRzoz2IPR8z7bOC2slI
W6YAoJixGrChz7dnwl9KnVWnMuV0/mrP
=+8pO
-----END PGP SIGNATURE-----

--nextPart1617379.v1b9jfCPID--
