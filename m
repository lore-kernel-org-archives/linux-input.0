From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Alps dualpoint touchpads losing sync [buttons fixed
	too]
Date: Wed, 18 Nov 2009 01:00:09 -0800
Message-ID: <20091118090009.GA2983@core.coreip.homeip.net>
References: <1258314158.9416.16.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60539 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbZKRJAH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2009 04:00:07 -0500
Received: by pwi3 with SMTP id 3so569524pwi.21
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2009 01:00:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1258314158.9416.16.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: Linux Input ML <linux-input@vger.kernel.org>

Hi Sebastian,

On Sun, Nov 15, 2009 at 08:42:38PM +0100, Sebastian Kapfer wrote:
> Fix Alps dualpoint touchpads (at the very least Dell E6x00 series)
> losing sync when touchpad and trackpoint are used at the same time.
> Hardware sends a different packet format than when either is used alone.
> This format was not recognised by the existing Alps driver.
> 
> This is slightly changed from the first patch, hanging buttons issue has
> been ironed out.
> 
> Has been tested by a number of people so far with good results.
> 

Thank you very much for your patch. I took the liberty of rearranging it a
bit, could you please trythe patch below and check that I did not screw
it up. It shoudl apply to the 'next' branch of my tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

I also need a "Signed-off-by:" line from you so I can get it into 2.6.33
queue. Thanks!

-- 
Dmitry

Input: ALPS - add interleaved protocol support (Dell E6x00 series)

From: Sebastian Kapfer <sebastian_kapfer@gmx.net>

Properly handle version of the protocol where standard PS/2 packets
from trackpoint are stuffed into middle (byte 3-6) of the standard
ALPS packets when both the touchpad and trackpoint are used together.

The patch is based on work done by Matthew Chapman and additional
research done by David Kubicek and Erik Osterholm:

	https://bugs.launchpad.net/ubuntu/+source/linux/+bug/296610

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |   87 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 68 insertions(+), 19 deletions(-)


diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a3f492a..9c91b0b 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
  * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
  * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2009 Sebastian Kapfer <sebastian_kapfer@gmx.net>
  *
  * ALPS detection, tap switching and status querying info is taken from
  * tpconfig utility (by C. Scott Ananian and Bruce Kall).
@@ -28,7 +29,6 @@
 #define dbg(format, arg...) do {} while (0)
 #endif
 
-
 #define ALPS_OLDPROTO		0x01	/* old style input */
 #define ALPS_DUALPOINT		0x02	/* touchpad has trackstick */
 #define ALPS_PASS		0x04	/* device has a pass-through port */
@@ -37,7 +37,8 @@
 #define ALPS_FW_BK_1		0x10	/* front & back buttons present */
 #define ALPS_FW_BK_2		0x20	/* front & back buttons present */
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
-
+#define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
+					   6-byte ALPS packet */
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Toshiba Salellite Pro M10 */
@@ -58,7 +59,9 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x20, 0x02, 0x0e },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* XXX */
 	{ { 0x22, 0x02, 0x0a },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
-	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude E6500 */
+	/* Dell Latitude E6400, E6500, Precision M4400 */
+	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 };
 
@@ -69,7 +72,13 @@ static const struct alps_model_info alps_model_data[] = {
  */
 
 /*
- * ALPS abolute Mode - new format
+ * PS/2 packet format
+ *
+ * byte 0: YOFL XOFL YSGN XSGN  1    M    R    L
+ * byte 1: X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 2: Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ *
+ * ALPS absolute Mode - new format
  *
  * byte 0:  1    ?    ?    ?    1    ?    ?    ?
  * byte 1:  0   x6   x5   x4   x3   x2   x1   x0
@@ -78,6 +87,20 @@ static const struct alps_model_info alps_model_data[] = {
  * byte 4:  0   y6   y5   y4   y3   y2   y1   y0
  * byte 5:  0   z6   z5   z4   z3   z2   z1   z0
  *
+ * Dualpoint device -- interleaved packet format
+ *
+ * byte 0:    1    1    0    0    1    1    1    1
+ * byte 1:    0   x6   x5   x4   x3   x2   x1   x0
+ * byte 2:    0  x10   x9   x8   x7    0  fin  ges
+ * byte 3: YOFL XOFL YSGN XSGN    1    1    1    1
+ * byte 4:   X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 5:   Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ * byte 6:    0   y9   y8   y7    1    m    r    l
+ * byte 7:    0   y6   y5   y4   y3   y2   y1   y0
+ * byte 8:    0   z6   z5   z4   z3   z2   z1   z0
+ *
+ * CAPITALS = stick, miniscules = touchpad
+ *
  * ?'s can have different meanings on different models,
  * such as wheel rotation, extra buttons, stick buttons
  * on a dualpoint, etc.
@@ -93,18 +116,6 @@ static void alps_process_packet(struct psmouse *psmouse)
 	int x, y, z, ges, fin, left, right, middle;
 	int back = 0, forward = 0;
 
-	if ((packet[0] & 0xc8) == 0x08) {   /* 3-byte PS/2 packet */
-		input_report_key(dev2, BTN_LEFT,   packet[0] & 1);
-		input_report_key(dev2, BTN_RIGHT,  packet[0] & 2);
-		input_report_key(dev2, BTN_MIDDLE, packet[0] & 4);
-		input_report_rel(dev2, REL_X,
-			packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
-		input_report_rel(dev2, REL_Y,
-			packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
-		input_sync(dev2);
-		return;
-	}
-
 	if (model->flags & ALPS_OLDPROTO) {
 		left = packet[2] & 0x10;
 		right = packet[2] & 0x08;
@@ -202,25 +213,63 @@ static void alps_process_packet(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
+static void alps_report_bare_ps2_packet(unsigned char packet[],
+					struct input_dev *dev)
+{
+	input_report_key(dev, BTN_LEFT,   packet[0] & 1);
+	input_report_key(dev, BTN_RIGHT,  packet[0] & 2);
+	input_report_key(dev, BTN_MIDDLE, packet[0] & 4);
+	input_report_rel(dev, REL_X,
+		packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
+	input_report_rel(dev, REL_Y,
+		packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
+	input_sync(dev);
+}
+
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
+	const struct alps_model_info *model = priv->i;
 
 	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
 		if (psmouse->pktcnt == 3) {
-			alps_process_packet(psmouse);
+			alps_report_bare_ps2_packet(psmouse->packet,
+						    priv->dev2);
 			return PSMOUSE_FULL_PACKET;
 		}
 		return PSMOUSE_GOOD_DATA;
 	}
 
-	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0)
+	/* Check for PS/2 packet stuffed in the middle of ALPS packet. */
+
+	if ((model->flags & ALPS_PS2_INTERLEAVED) &&
+	    psmouse->pktcnt >= 4 && (psmouse->packet[3] & 0x0f) == 0x0f) {
+		if (psmouse->pktcnt < 7)
+			return PSMOUSE_GOOD_DATA;
+
+		/* Get the real button data */
+		psmouse->packet[3] &= psmouse->packet[6] & 0x0f;
+		alps_report_bare_ps2_packet(&psmouse->packet[3],
+					    priv->dev2);
+
+		/* Continue with the standard ALPS protocol handling */
+		psmouse->packet[3] = psmouse->packet[6];
+		psmouse->pktcnt = 4;
+	}
+
+	if ((psmouse->packet[0] & model->mask0) != model->byte0) {
+		dbg("refusing packet[0] = %x (mask0 = %x, byte0 = %x)\n",
+		    psmouse->packet[0], model->mask0, model->byte0);
 		return PSMOUSE_BAD_DATA;
+	}
 
 	/* Bytes 2 - 6 should have 0 in the highest bit */
 	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
-	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
+	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
+		dbg("refusing packet[%i] = %x\n",
+		    psmouse->pktcnt - 1, psmouse->packet[psmouse->pktcnt - 1]);
 		return PSMOUSE_BAD_DATA;
+	}
 
 	if (psmouse->pktcnt == 6) {
 		alps_process_packet(psmouse);
