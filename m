From: Chow Loong Jin <hyperair@ubuntu.com>
Subject: Thinkpad Edge E220S trackpoint detection [was: Re: Lenovo X220 Touchpad
 + Trackpoint BIOS issue workaround ?]
Date: Tue, 04 Oct 2011 18:19:04 +0800
Message-ID: <4E8ADD98.5000402@ubuntu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8165FB0829D38CFB99CA4BF"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39314 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab1JDKTJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 06:19:09 -0400
Received: by iakk32 with SMTP id k32so405960iak.19
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 03:19:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8165FB0829D38CFB99CA4BF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

I was reading through the linux-input thread (as mentioned in the subject=
)
regarding trackpoint detection, and noticed that it bore an uncanny resem=
blence
to the issue I'm currently having with my Thinkpad Edge E220S. I'll summa=
rize
the situation on my E220S here, which I believe to be more or less the sa=
me as
the situation on the X220:
 - Main device is a Synaptics touchpad/
 - Trackpoint exists as a passthrough device/
 - Trackpoint not detected until first resynchronization happens.
 - Loss of sync can be triggered by moving the (undetected) trackpoint/

There seems to be a slight difference here though, in that I can't disabl=
e the
trackpoint or touchpad in my BIOS.

I noticed that you requested for the full i8042.debug output, so I looked=
 into
doing just that, using the following steps:
1. rmmod psmouse
2. echo 1 > /sys/module/i8042/parameters/debug
3. modprobe psmouse
4. wait for i8042 to settle and stop spewing messages
5. move the trackpoint a bit.
6. wait for i8042 to settle and stop spewing messages again.

I have attached two snippets of /var/log/kern.log files to this email:
 - modprobe-psmouse-until-settle.log: The log output between steps #3 and=
 #4.
 - touch-trackpoint-until-settle2.log: The log output between steps #5 an=
d #6.

There are no messages output in between the two log files. I have just sp=
lit
them for easier consumption (especially considering that the second log f=
ile is
4210 lines long).

Please let me know if you need more information.

Also, please CC me for replies, as I am not subscribed to this list.

--=20
Kind regards,
Loong Jin


--------------enigA8165FB0829D38CFB99CA4BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJOit2YAAoJEPvVIltYh1KhAAoP/R3xP1wdBpeAU0P9m1mu1Ldp
Tmd30AayL2F74vWYE1dGkrOSzw9PU8cMwfm/JmnzbotjtNNOFAnqIB1pUKbeo1D0
F3uzBqUxPTUyTAYyYeiBsIh+OBkPpckDf2LOlM5FWO6BCdUKjBs5FyFZTbsDT7Gk
wh1LgZdAY85WBH2YW1y1x95c1CqSOEpCJ/vwS3wR1j49ymFW2a6/OxhqkbwCNsrs
xQwqFI02aPhs1Y9fUs/3CzRleWt8w8495RFTNCgjhO2jk7RvbvX4j1SaiCQQ38HD
Dr77LIXMoCIAJxfuSZxBxxx84rD5oJ0UEThARfDWJVaFAtrr4P8yXMJ+Xx0ckydF
HoToxDm4Kb8ysHo0Gqdnwyju++p6e+Ktdc8qj7S2Qgl5oMP0PkOvCYHgNuq5h42T
NjpnMvLkQwm3d58SlMlHBTTgrDERbuI5Cx7Yr9NxL2Ad9TW9dW6syNfpBQEgw6kB
DceNdYLtLRq24HqY/+/PpxUjOhZ9T4sGz73sn4mKCESIBTv8zcHm8/B5CgbsL6XJ
u5GVfaS5Hhe5GUYcNbSkudmYN8cDqjmnyBCLYN0Y+srC/kQctntthSXGy6udxPfd
RaydYF612REKFhjO/Sk/SAzbD79Dm0WMvrpbMfOrZnyWh24GQS/acxQnbw87Hxhw
Fg5yNvQyDxhQKRji9bIS
=jYZ3
-----END PGP SIGNATURE-----

--------------enigA8165FB0829D38CFB99CA4BF--
