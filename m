From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"
Date: Fri, 19 May 2017 20:46:16 +0200
Message-ID: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v3eEalJr5FlkfDvEoQgfdqDtWqwlXnG0P"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web02.pwsrv.de ([188.68.38.65]:49812 "EHLO web02.pwsrv.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753312AbdESSw0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 14:52:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v3eEalJr5FlkfDvEoQgfdqDtWqwlXnG0P
Content-Type: multipart/mixed; boundary="pG8pWUB11fhNhLmlGtVocJPtCike7s059";
 protected-headers="v1"
From: Pascal Wichmann <pascal.wichmann@pa-w.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
Subject: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not
 recognized anymore; commit e839ffa: "Input: synaptics - add support for
 Intertouch devices"

--pG8pWUB11fhNhLmlGtVocJPtCike7s059
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello,

using the latest 4.12-rc1 kernel, the trackpoint and touchpad of my
Thinkpad X250 are not recognized.

This is caused by commit
e839ffa  Input: synaptics - add support for Intertouch devices


The specific problem seems to be the detection of whether to use
synaptics_intertouch for the psmouse module or not. That parameter
is set to -1 by default, in which case synaptics_intertouch is
enabled on my device.

When I explicitly set that parameter to 0, the trackpoint and touchpad
are recognized and work as expected.

Removing my device from smbus_pnp_ids in 4.12 rc1 fixes the issue
without need to manually disable synaptics_intertouch in the psmouse
module:

diff -ruN a/drivers/input/mouse/synaptics.c
b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2017-05-19 19:31:48.930734395 +0200=

+++ b/drivers/input/mouse/synaptics.c	2017-05-19 19:32:00.490782484 +0200=

@@ -170,7 +170,6 @@
 static const char * const smbus_pnp_ids[] =3D {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras *=
/
 	"LEN0048", /* X1 Carbon 3 */
-	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN200f", /* T450s */
 	NULL


Is the ThinkPad X250 not supporting intertouch or is there another
problem causing the input devices not to work with it enabled?


Regards,
Pascal



--pG8pWUB11fhNhLmlGtVocJPtCike7s059--

--v3eEalJr5FlkfDvEoQgfdqDtWqwlXnG0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAlkfPXgACgkQ6+YIa34W
/zbBug//WkRlG4Zr8V1PWa3tKsGXT78uGacSxE1+p+YUtqRvPjd7obhc3XCJUbkF
e96ZVMOVS0oj5Gez8Wsl1I4hLItlMNvvEPkCIzr32YTseiHFRwUMoQbWuXl42fnn
Syo13qwjZIfme0gUyEAOzuqszx3hNrZjxIVnMbOqudtG6Oxrb5GEg/68guq3zK7n
tDTkAa5whvYSb5KXdxGByxhGcqidYsN+A74sqXchvPwm7oYoWBMUOy00N7prR32p
HczueUwwYzM5tG+AFuMI73sD9GsQxrR6juukz00tJwXDY8U4nToibgRignGshREo
xgMvy56YK8AVBcJlRlnujJVz+TKJXwNG4RbTo+DkIzb3WCelqEXjSzD6hIs0/yL4
DaXrmSzAdCJFeI0v4xL2Y2PEHO7YaFgnWkmR08RVzF5i+NkVR/WkmwsBIkHv99yK
Ho7Qvd4eTEHfty03DGV7wnrrCEIJD/oRMPn3dmC+FQVOcVtPlkFfHB8T0qGeAPPV
3Uvhc+zhlqHlyrCPWGS4w83U9ar1zQr1mmr2Z5bbIV2qwp7Y/vb/e3l6pnaHU1aA
oPuQwKlF7kcnz7qCpLammPHk0uoHp2dGuWUj/YMJpewY3DuDKLu30zai3OHZxs1S
nVzPoohVqA/K1T0g/Ocval+s0g2HBpFjjw7Ti8gXijYNAQZBiAs=
=hQJj
-----END PGP SIGNATURE-----

--v3eEalJr5FlkfDvEoQgfdqDtWqwlXnG0P--
