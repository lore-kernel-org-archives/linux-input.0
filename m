From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: [PATCH 2/2] Alps Dualpoint, Interleaved packets
Date: Sun, 13 Dec 2009 23:09:05 +0100
Message-ID: <1260742145.9901.18.camel@sardelle.necksus.de>
References: <1259513695.32495.171.camel@sardelle.necksus.de>
	 <20091204084902.GB22570@core.coreip.homeip.net>
	 <1259963240.27307.213.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754488AbZLMWJH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 17:09:07 -0500
In-Reply-To: <1259963240.27307.213.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Linux Input ML <linux-input@vger.kernel.org>


... and this fixes the double-click issue when flooded with packets.  It
makes sure we never set the same mouse button on both dev and dev2.
When the button is released, it releases on both devices, since we don't
record which of them got the initial button-down.

Greetings,
 Sebastian



Date: Sun, 13 Dec 2009 22:44:10 +0100
Subject: [PATCH 2/2] fix double-click issue


Input: ALPS - add interleaved protocol support (Dell E6x00 series)

From: Sebastian Kapfer <sebastian_kapfer@gmx.net>

Fix a race between the button-down and the button-up events which could
lead to a single physical click on an Alps dualpoint unit being reported
as a double-click in X11.

This patch ensures that any click is assigned to only of the two
input_devs associated with the dualpoint unit, and never reported on the
other input_dev.

Signed-off-by: Sebastian Kapfer <sebastian_kapfer@gmx.net>


---
 drivers/input/mouse/alps.c |   78 ++++++++++++++++++++++++++------------------
 drivers/input/mouse/alps.h |    3 +-
 2 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 71b40ae..10b591c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -39,6 +39,7 @@
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
 #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
 					   6-byte ALPS packet */
+#define ALPS_SHARED_BTNSTATE	0x100	/* PS/2 and touchpad share button st. */
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Toshiba Salellite Pro M10 */
@@ -61,7 +62,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
 	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
 	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
-		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED | ALPS_SHARED_BTNSTATE },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 };
 
@@ -108,18 +109,49 @@ static const struct alps_model_info alps_model_data[] = {
  * on a dualpoint, etc.
  */
 
-static void alps_report_buttons(struct input_dev *dev,
-				int left, int right, int middle,
-				bool release_only)
+static void alps_report_single_button(struct psmouse *psmouse,
+				      int keycode, int mask, int state,
+				      struct input_dev *dev)
 {
-	if (!left || !release_only)
-		input_report_key(dev, BTN_LEFT, left);
+	struct alps_data *priv = psmouse->private;
+	const struct alps_model_info *model = priv->i;
 
-	if (!right || !release_only)
-		input_report_key(dev, BTN_RIGHT, right);
+	/* some Alps units do not report touchpad and trackpoint
+	   buttons separately (e.g. even the trackpoint movement
+	   packets have buttons set while touchpad buttons are down) */
+	if (model->flags & ALPS_SHARED_BTNSTATE) {
+		if (state) {
+			/* need to avoid sending a button-down to both
+			   devices (can cause spurious double-click */
+			if (priv->btn_state & mask)
+				return;
+
+			priv->btn_state |= mask;
+		} else {
+			/* we don't know which device got the button
+			   down event.  just release both to be sure. */
+			struct input_dev *other = psmouse->dev;
+			if (dev == other)
+				other = priv->dev2;
+			input_report_key(other, keycode, state);
+			input_sync(other);
+
+			priv->btn_state &= 7 ^ mask;
+		}
+	}
 
-	if (!middle || !release_only)
-		input_report_key(dev, BTN_MIDDLE, middle);
+	/* input_sync called by our caller */
+	input_report_key(dev, keycode, state);
+}
+
+
+static void alps_report_buttons(struct psmouse *psmouse,
+				struct input_dev *dev,
+				int left, int right, int middle)
+{
+	alps_report_single_button(psmouse, BTN_LEFT,   1, left,   dev);
+	alps_report_single_button(psmouse, BTN_RIGHT,  2, right,  dev);
+	alps_report_single_button(psmouse, BTN_MIDDLE, 4, middle, dev);
 }
 
 static void alps_process_packet(struct psmouse *psmouse)
@@ -167,25 +199,13 @@ static void alps_process_packet(struct psmouse *psmouse)
 		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
 		input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
 
-		alps_report_buttons(dev2, left, right, middle, false);
+		alps_report_buttons(psmouse, dev2, left, right, middle);
 
 		input_sync(dev2);
-		input_sync(dev);
 		return;
 	}
 
-	alps_report_buttons(dev, left, right, middle, false);
-
-	if (model->flags & ALPS_PS2_INTERLEAVED) {
-		/*
-		 * On devices using interleaved packets, when user presses
-		 * the same button on both trackpoint and touchpad, the
-		 * release for the trackpoint is not reported so we have
-		 * send release events to both devices.
-		 */
-		alps_report_buttons(dev2, left, right, middle, true);
-		input_sync(dev2);
-	}
+	alps_report_buttons(psmouse, dev, left, right, middle);
 
 	/* Convert hardware tap to a reasonable Z value */
 	if (ges && !fin)
@@ -248,14 +268,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		int right = packet[0] & 2;
 		int middle = packet[0] & 4;
 
-
-		if (priv->i->flags & ALPS_PS2_INTERLEAVED) {
-			alps_report_buttons(psmouse->dev,
-					    left, right, middle, true);
-			input_sync(psmouse->dev);
-		}
-
-		alps_report_buttons(dev2, left, right, middle, false);
+		alps_report_buttons(psmouse, dev2, left, right, middle);
 	}
 
 	input_report_rel(dev2, REL_X,
@@ -675,6 +688,7 @@ int alps_init(struct psmouse *psmouse)
 
 	priv->dev2 = dev2;
 	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
+	priv->btn_state = 0;
 
 	psmouse->private = priv;
 
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 904ed8b..b477063 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -15,7 +15,7 @@
 struct alps_model_info {
         unsigned char signature[3];
         unsigned char byte0, mask0;
-        unsigned char flags;
+        unsigned int flags;
 };
 
 struct alps_data {
@@ -23,6 +23,7 @@ struct alps_data {
 	char phys[32];			/* Phys */
 	const struct alps_model_info *i;/* Info */
 	int prev_fin;			/* Finger bit from previous packet */
+	int btn_state;			/* buttons reported to input_dev */
 	struct timer_list timer;
 };
 
-- 
1.6.3.3



