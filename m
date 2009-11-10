From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: [PATCH] Alps dualpoint touchpads losing sync
Date: Tue, 10 Nov 2009 01:20:23 +0100
Message-ID: <1257812423.6508.22.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52087 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755720AbZKJAUT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Nov 2009 19:20:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Alessandro Rubini <rubini@gnudd.com>

>From d53bf419ca1b035cd6db4a29e9f96190eca676b2 Mon Sep 17 00:00:00 2001
From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Date: Tue, 10 Nov 2009 00:51:42 +0100
Subject: [PATCH] Alps dualpoint touchpads losing sync

Fix Alps dualpoint touchpads (at the very least Dell E6x00 series) losing sync
when touchpad and trackpoint are used at the same time.  Hardware sends a
different packet format than when either is used alone.  This format was not
recognised by the existing Alps driver.

A similar patch has been tested by Matthew Chapman (see URL in patch);  my
version also fixes the buttons problem on his.

This is my first contribution to the Linux tree, so please bear with me :-)
One line is >80 chars, but this is to fit in with the rest of the code.

Signed-off-by: Sebastian Kapfer <sebastian_kapfer@gmx.net>

---
 drivers/input/mouse/alps.c    |   99 +++++++++++++++++++++++++++++++++++++----
 drivers/input/mouse/psmouse.h |    2 +-
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f361106..91750e7 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1,14 +1,18 @@
-/*
+/* vim:noet:sw=8:ts=8
  * ALPS touchpad PS/2 mouse driver
  *
  * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
  * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
  * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
  * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2009 Sebastian Kapfer <sebastian_kapfer@gmx.net>
  *
  * ALPS detection, tap switching and status querying info is taken from
  * tpconfig utility (by C. Scott Ananian and Bruce Kall).
  *
+ * Inspiration for parts of the multitouch codepath from a patch by
+ * Matthew Chapman.  (See http://lkml.org/lkml/2008/12/8/182 )
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
@@ -35,6 +39,13 @@
 #define ALPS_OLDPROTO	0x10
 #define ALPS_PASS	0x20
 #define ALPS_FW_BK_2	0x40
+/* capable of sending 9-byte packets.  these packets are recognized by having
+ * LMR buttons set.  if there were a dualpoint device with three mouse buttons,
+ * we could misrecognize, so an additional flag.  if your dualpoint device
+ * often loses sync, try adding ALPS_DUALPOINT9. */
+#define ALPS_DUALPOINT9	0x80
+
+#define DELL_STYLE_DUALPOINT (ALPS_DUALPOINT|ALPS_DUALPOINT9|ALPS_PASS)
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Toshiba Salellite Pro M10 */
@@ -55,7 +66,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x20, 0x02, 0x0e },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* XXX */
 	{ { 0x22, 0x02, 0x0a },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
-	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude E6500 */
+	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf, DELL_STYLE_DUALPOINT },       /* Dell Latitude E6500 */
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FW_BK_1 },		  /* Dell Vostro 1400 */
 };
 
@@ -65,8 +76,13 @@ static const struct alps_model_info alps_model_data[] = {
  * isn't valid per PS/2 spec.
  */
 
-/*
- * ALPS abolute Mode - new format
+/* PS/2 packet format
+ *
+ * byte 0: YOFL XOFL YSGN XSGN  1    M    R    L
+ * byte 1: X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 2: Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ *
+ * ALPS absolute Mode - new format
  *
  * byte 0:  1    ?    ?    ?    1    ?    ?    ?
  * byte 1:  0   x6   x5   x4   x3   x2   x1   x0
@@ -75,11 +91,26 @@ static const struct alps_model_info alps_model_data[] = {
  * byte 4:  0   y6   y5   y4   y3   y2   y1   y0
  * byte 5:  0   z6   z5   z4   z3   z2   z1   z0
  *
+ * Dualpoint device -- 9-byte packet format
+ *
+ * byte 0:  1    ?    ?    ?    1    ?    ?    ?
+ * byte 1:  0   x6   x5   x4   x3   x2   x1   x0
+ * byte 2:  0   x10  x9   x8   x7    ?  fin  ges
+ * byte 3: YOFL XOFL YSGN XSGN  1    1    1    1
+ * byte 4: X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 5: Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ * byte 6:  0   y9   y8   y7    1    m    r    l
+ * byte 7:  0   y6   y5   y4   y3   y2   y1   y0
+ * byte 8:  0   z6   z5   z4   z3   z2   z1   z0
+ *
+ * CAPITALS = stick, miniscules = touchpad
+ *
  * ?'s can have different meanings on different models,
  * such as wheel rotation, extra buttons, stick buttons
  * on a dualpoint, etc.
  */
 
+
 static void alps_process_packet(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -101,6 +132,31 @@ static void alps_process_packet(struct psmouse *psmouse)
 		return;
 	}
 
+	/* handle trackpoint part of a 9-byte packet,
+	   pass the rest on. */
+	if (priv->i->flags & ALPS_DUALPOINT9 && (packet[3] & 0xf) == 0xf) {
+		/* hardware does not indicate touchpad and trackpoint
+		   buttons separately to us when using 9-byte packets.
+		   i.e. both sets of buttons map to the same bits. yes,
+		   this sucks.  we 'clone' the events to both devices */
+		dbg("9p: byte0 = %x, byte3 = %x\n",
+		    (int)packet[0], (int)packet[3]);
+		dbg("buttons pressed = %i, z = %i\n",
+		    !!(packet[6] & 7), (int)packet[8]);
+		input_report_key(dev2, BTN_LEFT,   packet[6] & 1);
+		input_report_key(dev2, BTN_RIGHT,  packet[6] & 2);
+		input_report_key(dev2, BTN_MIDDLE, packet[6] & 4);
+		input_report_rel(dev2, REL_X,
+			packet[4] ? packet[4] - ((packet[3] << 4) & 0x100) : 0);
+		input_report_rel(dev2, REL_Y,
+			packet[5] ? ((packet[3] << 3) & 0x100) - packet[5] : 0);
+		input_sync(dev2);
+		/* touchpad data is handled below */
+		packet[3] = packet[6];
+		packet[4] = packet[7];
+		packet[5] = packet[8];
+	}
+
 	if (priv->i->flags & ALPS_OLDPROTO) {
 		left = packet[2] & 0x10;
 		right = packet[2] & 0x08;
@@ -191,6 +247,7 @@ static void alps_process_packet(struct psmouse *psmouse)
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
+	int length_full_packet = 6;
 
 	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
 		if (psmouse->pktcnt == 3) {
@@ -200,15 +257,39 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 		return PSMOUSE_GOOD_DATA;
 	}
 
-	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0)
+	/* must have been a non-PS/2 packet to even get here. */
+
+	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0) {
+		dbg("don't like packet[0] = %x (mask0 = %x, byte0 = %x\n",
+		    (int)psmouse->packet[0],
+		    (int)priv->i->mask0,
+		    (int)priv->i->byte0);
 		return PSMOUSE_BAD_DATA;
+	}
+
+	/* 9-byte packet format by dualpoint units */
+	if (priv->i->flags & ALPS_DUALPOINT9) {
+		/* is marked by a packet with LMR set */
+		if ((psmouse->pktcnt >= 4)
+		    && ((psmouse->packet[3] & 0xf) == 0xf)) {
+			length_full_packet = 9;
+			/* wave stick bytes through */
+			if (psmouse->pktcnt <= 6)
+				return PSMOUSE_GOOD_DATA;
+		}
+	}
 
-	/* Bytes 2 - 6 should have 0 in the highest bit */
-	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
-	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
+	/* Bytes 2 - 6 should have 0 in the highest bit for 6-byte packet */
+	/* Bytes 2, 3, and 7 through 9 should have for 9-byte packet      */
+	if (psmouse->pktcnt >= 2 &&
+	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
+		dbg("don't like packet[%i] = %x\n",
+		    psmouse->pktcnt - 1,
+		    (int)psmouse->packet[psmouse->pktcnt - 1]);
 		return PSMOUSE_BAD_DATA;
+	}
 
-	if (psmouse->pktcnt == 6) {
+	if (psmouse->pktcnt == length_full_packet) {
 		alps_process_packet(psmouse);
 		return PSMOUSE_FULL_PACKET;
 	}
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index e053bdd..d4772fe 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -42,7 +42,7 @@ struct psmouse {
 	struct delayed_work resync_work;
 	char *vendor;
 	char *name;
-	unsigned char packet[8];
+	unsigned char packet[9];
 	unsigned char badbyte;
 	unsigned char pktcnt;
 	unsigned char pktsize;
-- 
1.6.3.3



