From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v5 0/3] Input: ALPS - Bug fix and cleanup for SS5 hardware
Date: Fri, 11 Nov 2016 14:59:09 +0100
Message-ID: <201611111459.12642@pali>
References: <20161110151942.GA3969@pali> <1478796286-1924-1-git-send-email-linux-kernel@PaulSD.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2917540.YYrrEsBsaE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33131 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756633AbcKKN7Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Nov 2016 08:59:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so9642460wmu.0
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2016 05:59:15 -0800 (PST)
In-Reply-To: <1478796286-1924-1-git-send-email-linux-kernel@PaulSD.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@paulsd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

--nextPart2917540.YYrrEsBsaE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 10 November 2016 17:44:43 Paul Donohue wrote:
> This series includes a bug fix and assorted cleanup for the Alps SS5
> (SS4 v2) code.
>=20
> Changes in v5:
> * Moved TrackStick decoding logic to alps_process_packet_ss4_v2() to
>   make the code more consistent with other protocol versions
>   (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
>=20
> Changes in v4:
> * Fixed patch formatting issues
> * Correct casting issues in macros added in v3
>=20
> Changes in v3:
> * Added additional code cleanup to make the code easier to understand
>   (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
>=20
> Changes in v2:
> * For consistency with other Alps functions, check packet bytes for
>   packet type rather than adding a flag to alps_fields for packet
> type. (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
>=20
> Paul Donohue (3):
>   Input: ALPS - Fix TrackStick support for SS5 hardware
>   Input: ALPS - Clean up TrackStick handling for SS5 hardware
>   Input: ALPS - Clean up code for SS5 hardware
>=20
>  drivers/input/mouse/alps.c | 59
> +++++++++++++++++++++++++---------------------
> drivers/input/mouse/alps.h | 22 ++++++++++++++++-
>  2 files changed, 53 insertions(+), 28 deletions(-)

Whole patch series looks fine.
You can add my Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2917540.YYrrEsBsaE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlglzrAACgkQi/DJPQPkQ1JBWwCgnkGqLytA7nwRESN+nW1sDwqy
SBoAnRmAU6MWTIatiCITMxUFxDTfZoV6
=vS+f
-----END PGP SIGNATURE-----

--nextPart2917540.YYrrEsBsaE--
