From: Ben Hutchings <ben@decadent.org.uk>
Subject: HID: Add Apple wireless keyboard 2011 ANSI to special driver list
Date: Sun, 02 Dec 2012 14:38:23 +0000
Message-ID: <1354459103.7995.103.camel@deadeye.wl.decadent.org.uk>
References: <20121127151808.30093.1958.reportbug@ari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JXOz2ez0RjeF+ZEAA5io"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34144 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301Ab2LBOim (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2012 09:38:42 -0500
In-Reply-To: <20121127151808.30093.1958.reportbug@ari>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: 694546@bugs.debian.org, Ari Pollak <ari@scvngr.com>, linux-input@vger.kernel.org, Alexey Kaminsky <me@akaminsky.net>


--=-JXOz2ez0RjeF+ZEAA5io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit 0a97e1e9f9a6 ('HID: apple: Add Apple wireless keyboard 2011 ANSI PID=
')
did not update the special driver list in hid-core.c, so hid-generic may
still bind to this device.

Reported-by: Ari Pollak <ari@scvngr.com>
References: http://bugs.debian.org/694546
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: <stable@vger.kernel.org>
---
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1528,6 +1528,7 @@
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ANSI) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ISO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_JIS) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2011_ANSI) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2011_ISO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONL=
Y) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY=
) },


--=-JXOz2ez0RjeF+ZEAA5io
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAULtn3+e/yOyVhhEJAQqekQ//XVQrv14fZz0gPIMy/G7S+jih8mwka8Ee
xIG3FVSfovYsfpWKpYRlHp3x8nSdO5a6c5/Pi0HUZ+E2MMjUapbLjGtYyBHk9I6W
Uov8pB3L2ELvsJ2M3IZY9EM9yTVGCIasJgoN8OAZdGtJdZaHgro17YDhyiDCdvFi
+Dz2PA+RSMvawWcnTEGZXGAiFIyxbYuqAI4MWhOxsUdRMnEagxL/BJLG7gMk5Pvi
Z/sJYpINvqAUtT6qcAHDI1rrMDBMaNxM1MpKCMdV7laUTWCkeAcozvJV4GT2W6/0
phm5YJ2+wVxTB3xHf+pt0aLyMB4cnDYJT5eTW3/COVQlgmYQm4flIhxYIS9KD7dO
QECJifga05lY0wU1OdGIfZ/HXOxEGfrEwythp46A4a5pIT2kiLyfCg1lwjXSDaFE
taZVVdDb5ODtQwnJ0V0ophYdnX2WmLhNuxSDa9jOdCxM63Qrx/gTW0KAJaBHwIuO
Ew3XL39sSWV0WTYzS+V0zcUhu8BYgzRtoqk27NV6pD3d2qcp73YV81scL+bhUDEy
bu8x26JEe/qCdAt1ll7NizI+ZVH5p1XuiCeoL0yab0iajMAu++vBflrw9jErp/i5
her8IRNl5i0qrFFnjf1sN3ZolrqSPPk2f52+MI7kAZ/wQJMS4JE4fKnTRmghmCnU
KCWbOvnahIU=
=DVWb
-----END PGP SIGNATURE-----

--=-JXOz2ez0RjeF+ZEAA5io--
