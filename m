From: Arjan Opmeer <arjan@opmeer.net>
Subject: [PATCH] input: elantech.c provide a workaround for jumpy cursor on
	firmware 2.34
Date: Fri, 20 Mar 2009 06:35:09 +0100
Message-ID: <20090320053509.GA3633@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:37558 "EHLO
	smtp-out3.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbZCTFfS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2009 01:35:18 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

=46rom: Arjan Opmeer <arjan@opmeer.net>

It seems that Elantech touchpad firmware version 2.34 on the Hercules e=
CAF=C9
suffers from a problem where bogus coordinates get reported at the begi=
nning
of a touch action. This causes the mouse cursor or the scrolled page to
jump.

Included patch provides a workaround, enabled by default for firmware
version 2.34, that discards mouse packets that are likely to contain bo=
gus
coordinates. To allow users of other firmware versions, that may also s=
ee
this problem, to experiment the workaround can be enabled and disabled =
via a
sysfs entry.

Signed-off-by: Arjan Opmeer <arjan@opmeer.net>
---

diff --git a/Documentation/input/elantech.txt b/Documentation/input/ela=
ntech.txt
index a10c3b6..3156a8e 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -1,7 +1,7 @@
 Elantech Touchpad Driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-	Copyright (C) 2007-2008 Arjan Opmeer <arjan@opmeer.net>
+	Copyright (C) 2007-2009 Arjan Opmeer <arjan@opmeer.net>
=20
 	Extra information for hardware version 1 found and
 	provided by Steve Havelka
@@ -64,8 +64,8 @@ completeness sake.
 2. Extra knobs
    ~~~~~~~~~~~
=20
-Currently the Linux Elantech touchpad driver provides two extra knobs =
under
-/sys/bus/serio/drivers/psmouse/serio? for the user.
+Currently the Linux Elantech touchpad driver provides three extra knob=
s
+under /sys/bus/serio/drivers/psmouse/serio? for the user.
=20
 * debug
=20
@@ -98,6 +98,20 @@ Currently the Linux Elantech touchpad driver provide=
s two extra knobs under
    bits. Hence checking is disabled by default. Currently even turning=
 it on
    will do nothing.
=20
+* jumpy_cursor
+
+   Turns a workaround for jumpy mouse cursor ON or OFF.
+
+   By echo "0" to to this file the workaround will be turned OFF. Any
+   non-zero value will turn it ON. For firmware version 2.34 the defau=
lt is
+   ON.
+
+   Firmware version 2.34 seems to suffer from a problem where in the
+   starting phase of a touch action bogus coordinates are reported. Th=
is
+   causes the mouse cursor or the scrolled page to jump. This knob ena=
bles a
+   workaround that discards mouse packets likely to contain bogus
+   coordinates.
+
=20
 //////////////////////////////////////////////////////////////////////=
///////
=20
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 6ab0eb1..da3ff23 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1,7 +1,7 @@
 /*
- * Elantech Touchpad driver (v5)
+ * Elantech Touchpad driver (v6)
  *
- * Copyright (C) 2007-2008 Arjan Opmeer <arjan@opmeer.net>
+ * Copyright (C) 2007-2009 Arjan Opmeer <arjan@opmeer.net>
  *
  * This program is free software; you can redistribute it and/or modif=
y it
  * under the terms of the GNU General Public License version 2 as publ=
ished
@@ -178,6 +178,7 @@ static void elantech_report_absolute_v1(struct psmo=
use *psmouse)
 	struct elantech_data *etd =3D psmouse->private;
 	unsigned char *packet =3D psmouse->packet;
 	int fingers;
+	static int old_fingers;
=20
 	if (etd->fw_version_maj =3D=3D 0x01) {
 		/* byte 0:  D   U  p1  p2   1  p3   R   L
@@ -190,6 +191,14 @@ static void elantech_report_absolute_v1(struct psm=
ouse *psmouse)
 		fingers =3D (packet[0] & 0xc0) >> 6;
 	}
=20
+	if (etd->jumpy_cursor) {
+		/* Discard packets that are likely to have bogus coordinates */
+		if (fingers > old_fingers) {
+			elantech_debug("elantech.c: discarding packet\n");
+			goto discard_packet_v1;
+		}
+	}
+
 	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
=20
 	/* byte 2: x7  x6  x5  x4  x3  x2  x1  x0
@@ -216,6 +225,9 @@ static void elantech_report_absolute_v1(struct psmo=
use *psmouse)
 	}
=20
 	input_sync(dev);
+
+ discard_packet_v1:
+	old_fingers =3D fingers;
 }
=20
 /*
@@ -507,6 +519,7 @@ ELANTECH_INT_ATTR(reg_25, 0x25);
 ELANTECH_INT_ATTR(reg_26, 0x26);
 ELANTECH_INT_ATTR(debug, 0);
 ELANTECH_INT_ATTR(paritycheck, 0);
+ELANTECH_INT_ATTR(jumpy_cursor, 0);
=20
 static struct attribute *elantech_attrs[] =3D {
 	&psmouse_attr_reg_10.dattr.attr,
@@ -520,6 +533,7 @@ static struct attribute *elantech_attrs[] =3D {
 	&psmouse_attr_reg_26.dattr.attr,
 	&psmouse_attr_debug.dattr.attr,
 	&psmouse_attr_paritycheck.dattr.attr,
+	&psmouse_attr_jumpy_cursor.dattr.attr,
 	NULL
 };
=20
@@ -662,6 +676,17 @@ int elantech_init(struct psmouse *psmouse)
 		param[0], param[1], param[2]);
 	etd->capabilities =3D param[0];
=20
+	/*
+	 * This firmware seems to suffer from misreporting coordinates when
+	 * a touch action starts causing the mouse cursor or scrolled page
+	 * to jump. Enable a workaround.
+	 */
+	if (etd->fw_version_maj =3D=3D 0x02 && etd->fw_version_min =3D=3D 0x2=
2) {
+		pr_info("elantech.c: firmware version 2.34 detected, "
+			"enabling jumpy cursor workaround\n");
+		etd->jumpy_cursor =3D 1;
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		pr_err("elantech.c: failed to put touchpad into absolute mode.\n");
 		goto init_fail;
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index bee282b..ed848cc 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -1,7 +1,7 @@
 /*
- * Elantech Touchpad driver (v5)
+ * Elantech Touchpad driver (v6)
  *
- * Copyright (C) 2007-2008 Arjan Opmeer <arjan@opmeer.net>
+ * Copyright (C) 2007-2009 Arjan Opmeer <arjan@opmeer.net>
  *
  * This program is free software; you can redistribute it and/or modif=
y it
  * under the terms of the GNU General Public License version 2 as publ=
ished
@@ -104,6 +104,7 @@ struct elantech_data {
 	unsigned char fw_version_min;
 	unsigned char hw_version;
 	unsigned char paritycheck;
+	unsigned char jumpy_cursor;
 	unsigned char parity[256];
 };
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
