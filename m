From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: input: elantech.c: adding more Fujtisu notebooks to force crc_enabled
Date: Tue, 27 Jan 2015 09:20:57 +0100
Message-ID: <54C74A69.7060105@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:62382 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbA0Iaw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 03:30:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: dmitry.torokhov@gmail.com

Extending the patch from November 2014 with two more Fujitsu LIFEBOOK
models that also ship the Elantech touchpad and don't work with
crc_disabled.

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

---
My responsibility is enabling Linux on Fujitsu desktops and sometimes
also notebooks. Stumbled into this issue during investigation of a
customer project and successfully tested the patch on both machines.

diff -uNr old/drivers/input/mouse/elantech.c new/drivers/input/mouse/el=
antech.c
--- old/drivers/input/mouse/elantech.c	2015-01-27 08:51:18.101122218 +0=
100
+++ new/drivers/input/mouse/elantech.c	2015-01-27 08:51:00.880921663 +0=
100
@@ -1475,6 +1475,20 @@
 			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
 		},
 	},
+	{
+		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled =3D=3D 0 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E554"),
+		},
+	},
+	{
+		/* Fujitsu LIFEBOOK E544  does not work with crc_enabled =3D=3D 0 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
+		},
+	},
 #endif
 	{ }
 };

--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. PDG WPS R&D SW OSE

=46ujitsu Technology Solutions
B=C3=BCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
