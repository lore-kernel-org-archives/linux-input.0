From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 16:45:47 +0200
Message-ID: <201605251645.47346@pali>
References: <87eg9j6zf7.fsf@smart-cactus.org> <20160525073949.GY29844@pali> <87a8jejq3u.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12739835.FhybjykULR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35419 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbcEYOpw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 10:45:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id a136so129948402wme.0
        for <linux-input@vger.kernel.org>; Wed, 25 May 2016 07:45:51 -0700 (PDT)
In-Reply-To: <87a8jejq3u.fsf@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, Masaki Ota <masaki.ota@jp.alps.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Allen_Hung@dell.com, Mario_Limonciello@dell.com, linux-input@vger.kernel.org

--nextPart12739835.FhybjykULR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 May 2016 14:09:57 Ben Gamari wrote:
>     [  714.781858] psmouse: psmouse serio1: alps: E6 report: 00 00 64
>     [  714.804749] psmouse: psmouse serio1: alps: E7 report: 73 03 28
>     [  714.830829] psmouse: psmouse serio1: alps: EC report: 73 01 13
>     [  714.833568] psmouse: psmouse serio1: alps: Likely not an ALPS touc=
hpad: E7=3D73 03 28, EC=3D73 01 13

Great! This allow us to identify touchpad more precious.

Adding people who signed/acked alps commit which added V8 protocol
support. Above touchpad should has V8 protocol too. And it is with
trackstick.

Any idea why is not recognized?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart12739835.FhybjykULR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldFupsACgkQi/DJPQPkQ1I9KQCgxDVsbALYf8EGU99yWsfAdBTw
G7wAn2K+cNvfjk3ipg84xJVlbMQstnNs
=DXhi
-----END PGP SIGNATURE-----

--nextPart12739835.FhybjykULR--
