From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 6/6] Input: ALPS - mix trackstick and external PS/2 mouse data
Date: Thu, 15 Jan 2015 21:34:51 +0100
Message-ID: <201501152134.51503@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <1421276154-8689-7-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3613084.zyey6tsZdk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:40283 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbbAOUey (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 15:34:54 -0500
Received: by mail-we0-f175.google.com with SMTP id k11so16865050wes.6
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 12:34:53 -0800 (PST)
In-Reply-To: <1421276154-8689-7-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

--nextPart3613084.zyey6tsZdk
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 January 2015 23:55:54 Dmitry Torokhov wrote:
> From: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Previously dev2 device was used for both external PS/2 mouse
> and internal trackstick device (if available). This change
> introduces dev3 device which is used for external PS/2 mouse
> data and dev2 is now used only for trackstick.
>=20
> In case that trackstick is not present dev2 is not created, so
> userspace does not see non existent device in system.
>=20
> Because laptops with ALPS devices often do not use i8042
> active multiplexing all data (from touchpad, trackstick and
> external PS/2 mouse) come to one port.  So it is not possible
> to know if external PS/2 mouse is connected or not. In most
> cases external PS/2 mouse is not connected so driver will
> create dev3 input device after first bare PS/2 packet will be
> received. So there will not be "ghost" input device.
>=20
> This change also helps in identifying possible problems in
> future if driver decides to report 6-bytes trackstick packets
> as 3-bytes bare PS/2 (data will be reported to dev3 instead
> dev2).
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Subject should be: "do *not* mix" or "prevent mix"

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3613084.zyey6tsZdk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS4JGsACgkQi/DJPQPkQ1JEggCgvCmUw18bmw5tWMCMDLG/hdCg
R1wAoMhapWL+YOgQnC6vaPpuPDanDAbH
=eDl/
-----END PGP SIGNATURE-----

--nextPart3613084.zyey6tsZdk--
