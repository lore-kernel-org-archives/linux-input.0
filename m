From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] alps: Document that Protocol V2 uses standard PS/2 mouse packets for the stick
Date: Fri, 3 Apr 2015 08:21:29 +0200
Message-ID: <201504030821.29619@pali>
References: <1427962134-4871-1-git-send-email-hdegoede@redhat.com> <1427962134-4871-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3200410.bnbyFCHgin";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35565 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbDCGVd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Apr 2015 02:21:33 -0400
Received: by wgdm6 with SMTP id m6so103579892wgd.2
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2015 23:21:32 -0700 (PDT)
In-Reply-To: <1427962134-4871-2-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--nextPart3200410.bnbyFCHgin
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 02 April 2015 10:08:54 Hans de Goede wrote:
> Document that Protocol V2 uses standard (bare) PS/2 mouse
> packets for the DualPoint stick.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/input/alps.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/input/alps.txt
> b/Documentation/input/alps.txt index a63e5e0..92ae734 100644
> --- a/Documentation/input/alps.txt
> +++ b/Documentation/input/alps.txt
> @@ -114,6 +114,9 @@ ALPS Absolute Mode - Protocol Version 2
>   byte 4:  0   y6   y5   y4   y3   y2   y1   y0
>   byte 5:  0   z6   z5   z4   z3   z2   z1   z0
>=20
> +Protocol Version 2 DualPoint devices send standard PS/2 mouse
> packets for +the DualPoint Stick.
> +
>  Dualpoint device -- interleaved packet format
>  ---------------------------------------------
>=20
> @@ -127,6 +130,11 @@ Dualpoint device -- interleaved packet
> format byte 7:    0   y6   y5   y4   y3   y2   y1   y0
>   byte 8:    0   z6   z5   z4   z3   z2   z1   z0
>=20
> +Devices which use the interleaving format normally send
> standard PS/2 mouse +packets for the DualPoint Stick + ALPS
> Absolute Mode packets for the +touchpad, switching to the
> interleaved packet format when both the stick and +the
> touchpad are used at the same time.
> +
>  ALPS Absolute Mode - Protocol Version 3
>  ---------------------------------------

Acked-By: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3200410.bnbyFCHgin
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUeMWkACgkQi/DJPQPkQ1JbyACgisTYjssN7ZLuqGhLbBHrHLxR
EzEAn37vzLUIDfTvZp/Q6uLcnQhBONwE
=ZxCw
-----END PGP SIGNATURE-----

--nextPart3200410.bnbyFCHgin--
