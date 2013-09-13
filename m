From: Yunkang Tang <tommywill2011@gmail.com>
Subject: [PATCH v2 1/2] Add an additional argument for decode routine, change secondary device name
Date: Fri, 13 Sep 2013 12:03:29 +0800
Message-ID: <1379045010-3347-2-git-send-email-yunkang.tang@cn.alps.com>
References: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47456 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3IMEES (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Sep 2013 00:04:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so1992053pab.34
        for <linux-input@vger.kernel.org>; Thu, 12 Sep 2013 21:04:17 -0700 (PDT)
In-Reply-To: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: yunkang.tang@cn.alps.com, linux-input@vger.kernel.org

From: Yunkang Tang <yunkang.tang@cn.alps.com>

- Add an addition argument for decode routine, new devices need this info.
- Change the dev2's name from "PS/2 Mouse" to "ALPS PS/2 Device".

Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
---
 drivers/input/mouse/alps.c | 17 ++++++++++-------
 drivers/input/mouse/alps.h |  5 +++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 7c5d72a..7e8a4fb 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -461,7 +461,8 @@ static void alps_decode_buttons_v3(struct alps_fields *f, unsigned char *p)
 	f->ts_middle = !!(p[3] & 0x40);
 }
 
-static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
+static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
+				 struct psmouse *psmouse)
 {
 	f->first_mp = !!(p[4] & 0x40);
 	f->is_mp = !!(p[0] & 0x40);
@@ -482,15 +483,17 @@ static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
 	alps_decode_buttons_v3(f, p);
 }
 
-static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
+static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
+				 struct psmouse *psmouse)
 {
-	alps_decode_pinnacle(f, p);
+	alps_decode_pinnacle(f, p, psmouse);
 
 	f->x_map |= (p[5] & 0x10) << 11;
 	f->y_map |= (p[5] & 0x20) << 6;
 }
 
-static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p)
+static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
+				struct psmouse *psmouse)
 {
 	f->first_mp = !!(p[0] & 0x02);
 	f->is_mp = !!(p[0] & 0x20);
@@ -523,7 +526,7 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 	int fingers = 0, bmap_fingers;
 	struct alps_fields f;
 
-	priv->decode_fields(&f, packet);
+	priv->decode_fields(&f, packet, psmouse);
 
 	/*
 	 * There's no single feature of touchpad position and bitmap packets
@@ -552,7 +555,7 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 				fingers = bmap_fingers;
 
 			/* Now process position packet */
-			priv->decode_fields(&f, priv->multi_data);
+			priv->decode_fields(&f, priv->multi_data, psmouse);
 		} else {
 			priv->multi_packet = 0;
 		}
@@ -1792,7 +1795,7 @@ int alps_init(struct psmouse *psmouse)
 	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev.serio->phys);
 	dev2->phys = priv->phys;
 	dev2->name = (priv->flags & ALPS_DUALPOINT) ?
-		     "DualPoint Stick" : "PS/2 Mouse";
+		     "DualPoint Stick" : "ALPS PS/2 Device";
 	dev2->id.bustype = BUS_I8042;
 	dev2->id.vendor  = 0x0002;
 	dev2->id.product = PSMOUSE_ALPS;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index eee5985..cdc10f3 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -69,7 +69,7 @@ struct alps_nibble_commands {
  * @y: Y position for ST.
  * @z: Z position for ST.
  * @first_mp: Packet is the first of a multi-packet report.
- * @is_mp: Packet is part of a multi-packet report.
+ * @is_mp: Packet is the last of a multi-packet report.
  * @left: Left touchpad button is active.
  * @right: Right touchpad button is active.
  * @middle: Middle touchpad button is active.
@@ -145,7 +145,8 @@ struct alps_data {
 
 	int (*hw_init)(struct psmouse *psmouse);
 	void (*process_packet)(struct psmouse *psmouse);
-	void (*decode_fields)(struct alps_fields *f, unsigned char *p);
+	void (*decode_fields)(struct alps_fields *f, unsigned char *p,
+			      struct psmouse *psmouse);
 	void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
 
 	int prev_fin;
-- 
1.8.1.2

