From: Marty Plummer <netz.kernel@gmail.com>
Subject: Generic all-purpose keycodes for gaming keyboards?
Date: Fri, 13 Nov 2015 10:50:43 -0600
Message-ID: <564614E3.2050805@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="emDp5svxjtL9QWIf5vL5pxuBt3jnfUvEH"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35529 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbbKMQuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2015 11:50:52 -0500
Received: by ykba77 with SMTP id a77so155695815ykb.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2015 08:50:52 -0800 (PST)
Received: from [192.168.43.56] ([172.56.20.113])
        by smtp.gmail.com with ESMTPSA id f67sm22361968ywd.19.2015.11.13.08.50.51
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2015 08:50:51 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--emDp5svxjtL9QWIf5vL5pxuBt3jnfUvEH
Content-Type: multipart/mixed;
 boundary="------------010106090308030204090200"

This is a multi-part message in MIME format.
--------------010106090308030204090200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greetings,

As many of you are no doubt aware there has been a large amount of new 'g=
aming'
keyboards and mice entering the market from various manufacturers, each w=
ith
their own oddities and every developer that seeks to support them has in =
turn
came up with their own way to handle these keyboards. In particular my in=
terest
is in setting up some standard way to handle these, especially those with=
 macro
and/or profile buttons, such as mapping them to a set of specially purpos=
ed
keycodes (I've seen BTN_TRIGGER_HAPPY? used for this purpose, but I don't=
 think
that was the original intent for those keycodes) just for use with these =
sort of
devices, eg, BTN_KEYBOARD_MACRO? and BTN_KEYBOARD_PROFILE? and so on. How=
 doable
do you guys think such an infrastructure would be?

--------------010106090308030204090200
Content-Type: application/pgp-keys;
 name="0xC030918D.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xC030918D.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
PDE9Qw9g6bHvAnTue6j5eKZcjA=3D=3D
=3DF/fe
-----END PGP PUBLIC KEY BLOCK-----

--------------010106090308030204090200--

--emDp5svxjtL9QWIf5vL5pxuBt3jnfUvEH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWRhTpAAoJEHWEtN3AMJGNPfkQAJMWne4LJQsvgoJno8vVP+/c
8leshYpY/rMmaCqEq/NFrqKtfn9VT2JmYViBzkRqD4JOl2pF6ksRrXjjklxYRpTT
dE8zkL/UT3+nkEB5r+flkNI6md4B+FiEyra37m81/XZcCP67V1Oir133EaJVOIGI
wNH/lKxWS0usOQZ9evd15dQ1/ihKxfSbGRpcL6EkkYniHcytjazY4uBH5+E0ixSF
rDTHzQaEuhdDPXFz1u84DgOFuaRFNGrNjsurb/ss8uU/OnQLWakXmISxcyj8de0H
gv6KXPrIuPHgyQkjL2zGUe+OJBBQXjp2Mf0P0Tk28xDx5FIG7PI0Zd8cLq+Pj+xn
3RKrJwzfCXx4K75+taAzEFv1Tl/21xPeGYCrLMp39qcWsjZU2kIhc9kE31tI6oB8
We9fbg2p3kwcTnHpOoQ738vlGQW0gZV2It1HbFtJj44i0L+3mFJIw1msktTZdJJL
ZoE3mo7ExGM3zG1wxpGmTTJr9TLkwcK4XNnGK0lCpvIuWa/mNRTORsq1Sh+KxC0k
B8DZ/N9RWCbN1kml0YKmHhrwCE3XFtikjTRaiIJLmlF0SGn1a/3NY9kKoXysmpYx
+4Us9WPAcD8ZGTUVaY8qpkvJOsKLmqT+FMUWnQ0Krxzgn3cHm+zcjN6/pLTF8/va
j176LuaNO8zlfP3lyALa
=tLOp
-----END PGP SIGNATURE-----

--emDp5svxjtL9QWIf5vL5pxuBt3jnfUvEH--
