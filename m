From: Niels de Vos <niels.devos@wincor-nixdorf.com>
Subject: [PATCH] serio.h: trivial documentation fix
Date: Tue, 08 Jul 2008 11:19:21 +0200
Message-ID: <48733119.5080502@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25BF37E1391462482A0740CD"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxpdbe1.wincor-nixdorf.com ([80.154.98.129]:54841 "EHLO
	mxpdbe1.wincor-nixdorf.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751394AbYGHJba (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Jul 2008 05:31:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25BF37E1391462482A0740CD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

In include/linux/serio.h two different define-series are
documented as "Serio types". However the second series contains
defines for the different protocols.

Signed-off-by: Niels de Vos <niels.devos@wincor-nixdorf.com>
---
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 95674d9..1ed3998 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -175,7 +175,7 @@ static inline void serio_unpin_driver(struct serio *s=
erio)
#define SERIO_8042_XL  0x06

/*
- * Serio types
+ * Serio protocols
 */
#define SERIO_UNKNOWN  0x00
#define SERIO_MSC      0x01


--------------enig25BF37E1391462482A0740CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFIczEZ5KAkGQPO/QoRAvbAAKDWdy0JFEJcTZtTEJUh9oTHBZXXnwCfdSdF
uGS7Kx8JZvRdV3/MtPmo31M=
=0MwQ
-----END PGP SIGNATURE-----

--------------enig25BF37E1391462482A0740CD--
