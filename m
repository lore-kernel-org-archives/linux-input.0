From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: [RFC, PATCH] horizontal mouse wheel in mousedrv
Date: Tue, 25 Dec 2007 16:49:21 +0100
Message-ID: <20071225164921.16bccae3@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway.drzeus.cx ([85.8.24.16]:53185 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbXLYPt0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Dec 2007 10:49:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Pierre Ossman <drzeus@drzeus.cx>

Support the horizontal wheel present on many mice via the
/dev/input/mice device by using the somewhat odd protocol extension
of sending double wheel movements for the extra wheel.

This is of course a rather error prone protocol extension, but it is
found in some hardware and works well enough in practice. It is also
the only horizontal wheel protocol supported by Xorg's mouse driver.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 78c3ea7..2976b42 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -50,7 +50,7 @@ module_param(tap_time, uint, 0644);
 MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
 
 struct mousedev_hw_data {
-	int dx, dy, dz;
+	int dx, dy, dz, dw;
 	int x, y;
 	int abs_event;
 	unsigned long buttons;
@@ -85,7 +85,7 @@ enum mousedev_emul {
 };
 
 struct mousedev_motion {
-	int dx, dy, dz;
+	int dx, dy, dz, dw;
 	unsigned long buttons;
 };
 
@@ -215,6 +215,10 @@ static void mousedev_rel_event(struct mousedev *mousedev,
 	case REL_WHEEL:
 		mousedev->packet.dz -= value;
 		break;
+
+	case REL_HWHEEL:
+		mousedev->packet.dw += value;
+		break;
 	}
 }
 
@@ -297,9 +301,10 @@ static void mousedev_notify_readers(struct mousedev *mousedev,
 		p->dx += packet->dx;
 		p->dy += packet->dy;
 		p->dz += packet->dz;
+		p->dw += packet->dw;
 		p->buttons = mousedev->packet.buttons;
 
-		if (p->dx || p->dy || p->dz ||
+		if (p->dx || p->dy || p->dz || p->dw ||
 		    p->buttons != client->last_buttons)
 			client->ready = 1;
 
@@ -394,7 +399,7 @@ static void mousedev_event(struct input_handle *handle,
 			mousedev_notify_readers(mousedev_mix, &mousedev->packet);
 
 			mousedev->packet.dx = mousedev->packet.dy =
-				mousedev->packet.dz = 0;
+				mousedev->packet.dz = mousedev->packet.dw = 0;
 			mousedev->packet.abs_event = 0;
 		}
 		break;
@@ -602,8 +607,13 @@ static void mousedev_packet(struct mousedev_client *client,
 
 	switch (client->mode) {
 	case MOUSEDEV_EMUL_EXPS:
-		ps2_data[3] = mousedev_limit_delta(p->dz, 7);
-		p->dz -= ps2_data[3];
+		if (p->dw) {
+			ps2_data[3] = mousedev_limit_delta(2 * p->dw, 7);
+			p->dw -= ps2_data[3] / 2;
+		} else {
+			ps2_data[3] = mousedev_limit_delta(p->dz, 7);
+			p->dz -= ps2_data[3];
+		}
 		ps2_data[3] = (ps2_data[3] & 0x0f) | ((p->buttons & 0x18) << 1);
 		client->bufsiz = 4;
 		break;
@@ -625,7 +635,7 @@ static void mousedev_packet(struct mousedev_client *client,
 		break;
 	}
 
-	if (!p->dx && !p->dy && !p->dz) {
+	if (!p->dx && !p->dy && !p->dz && !p->dw) {
 		if (client->tail == client->head) {
 			client->ready = 0;
 			client->last_buttons = p->buttons;
