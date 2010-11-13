From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 3/4] Input: hgpk - Fix powersave mode
Date: Sat, 13 Nov 2010 19:22:21 +0000 (GMT)
Message-ID: <20101113192221.E7FBC9D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49858 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932084Ab0KMTWZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Nov 2010 14:22:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

From: Paul Fox <pgf@laptop.org>

Recent testing of this codepath showed that it wasn't working,
perhaps due to changes within the input layer. This fixes it.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 95cef49..4917a08 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -689,11 +689,15 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 }
 
 /*
- * This kills power to the touchpad; according to ALPS, current consumption
- * goes down to 50uA after running this.  To turn power back on, we drive
- * MS-DAT low.
+ * This puts the touchpad in a power saving mode; according to ALPS, current
+ * consumption goes down to 50uA after running this.  To turn power back on,
+ * we drive MS-DAT low.  Measuring with a 1mA resolution ammeter says that
+ * the current on the SUS_3.3V rail drops from 3mA or 4mA to 0 when we do this.
+ *
+ * We have no formal spec that details this operation -- the low-power
+ * sequence came from a long-lost email trail.
  */
-static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
+static int hgpk_toggle_powersave(struct psmouse *psmouse, int enable)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	int timeo;
@@ -711,13 +715,13 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 		 * the controller.  Once we get an ACK back from it, it
 		 * means we can continue with the touchpad re-init.  ALPS
 		 * tells us that 1s should be long enough, so set that as
-		 * the upper bound.
+		 * the upper bound. (in practice, it takes about 3 loops.)
 		 */
 		for (timeo = 20; timeo > 0; timeo--) {
 			if (!ps2_sendbyte(&psmouse->ps2dev,
 					PSMOUSE_CMD_DISABLE, 20))
 				break;
-			msleep(50);
+			msleep(25);
 		}
 
 		err = hgpk_reset_device(psmouse, false);
@@ -729,10 +733,9 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 		/* should be all set, enable the touchpad */
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
-
+		hgpk_dbg(psmouse, "Touchpad powered up.\n");
 	} else {
 		hgpk_dbg(psmouse, "Powering off touchpad.\n");
-		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
 		if (ps2_command(ps2dev, NULL, 0xec) ||
 		    ps2_command(ps2dev, NULL, 0xec) ||
@@ -740,6 +743,8 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 			return -1;
 		}
 
+		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+
 		/* probably won't see an ACK, the touchpad will be off */
 		ps2_sendbyte(&psmouse->ps2dev, 0xec, 20);
 	}
@@ -755,6 +760,8 @@ static int hgpk_poll(struct psmouse *psmouse)
 
 static int hgpk_reconnect(struct psmouse *psmouse)
 {
+	struct hgpk_data *priv = psmouse->private;
+
 	/*
 	 * During suspend/resume the ps2 rails remain powered.  We don't want
 	 * to do a reset because it's flush data out of buffers; however,
@@ -765,6 +772,7 @@ static int hgpk_reconnect(struct psmouse *psmouse)
 				PM_EVENT_ON)
 			return 0;
 
+	priv->powered = 1;
 	return hgpk_reset_device(psmouse, false);
 }
 
@@ -791,7 +799,7 @@ static ssize_t hgpk_set_powered(struct psmouse *psmouse, void *data,
 		 * hgpk_toggle_power will deal w/ state so
 		 * we're not racing w/ irq
 		 */
-		err = hgpk_toggle_power(psmouse, value);
+		err = hgpk_toggle_powersave(psmouse, value);
 		if (!err)
 			priv->powered = value;
 	}
-- 
1.7.3.2

