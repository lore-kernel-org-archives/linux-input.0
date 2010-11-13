From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 2/4] Input: hgpk - Recalibration tweaks
Date: Sat, 13 Nov 2010 19:22:11 +0000 (GMT)
Message-ID: <20101113192212.21E189D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:49836 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932084Ab0KMTWT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Nov 2010 14:22:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Disable the recalibration guard where new recalibrations are triggered
if we detect a packet too soon after calibrating - we found that this
results in erroneous recalibrations, and if the recalibration failed
then the rest of our badness-detection code will request another.

Add a module option disabling all of the recalibration code, in case
an OLPC deployment thinks all of the workarounds we have are doing
more damage than good and wants to experiment with them all disabled.

Based on work by Paul Fox.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 7f6cb32..95cef49 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -62,16 +62,20 @@ module_param(spew_delay, int, 0644);
 MODULE_PARM_DESC(spew_delay,
 	"delay (ms) before recal after packet spew detected");
 
-static int recal_guard_time = 2000;
+static int recal_guard_time;
 module_param(recal_guard_time, int, 0644);
 MODULE_PARM_DESC(recal_guard_time,
 	"interval (ms) during which recal will be restarted if packet received");
 
-static int post_interrupt_delay = 1000;
+static int post_interrupt_delay = 40;
 module_param(post_interrupt_delay, int, 0644);
 MODULE_PARM_DESC(post_interrupt_delay,
 	"delay (ms) before recal after recal interrupt detected");
 
+static int autorecal = 1;
+module_param(autorecal, int, 0644);
+MODULE_PARM_DESC(autorecal, "enable recalibration in the driver");
+
 static char hgpk_mode_name[16];
 module_param_string(hgpk_mode, hgpk_mode_name, sizeof(hgpk_mode_name), 0644);
 MODULE_PARM_DESC(hgpk_mode,
@@ -642,6 +646,13 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	if (psmouse->model < HGPK_MODEL_C)
 		return 0;
 
+	if (!autorecal) {
+		hgpk_dbg(psmouse, "recalibrations disabled, ignoring\n");
+		return 0;
+	}
+
+	hgpk_dbg(psmouse, "recalibrating touchpad..\n");
+
 	/* we don't want to race with the irq handler, nor with resyncs */
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
@@ -662,13 +673,17 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 
+	if (tpdebug)
+		hgpk_dbg(psmouse, "touchpad reactivated\n");
+
 	/*
-	 * After we recalibrate, we shouldn't get any packets for 2s.  If
-	 * we do, it's likely that someone's finger was on the touchpad.
-	 * If someone's finger *was* on the touchpad, it's probably
-	 * miscalibrated.  So, we should schedule another recalibration
+	 * If we get packets right away after recalibrating, it's likely
+	 * that a finger was on the touchpad.  If so, it's probably
+	 * miscalibrated, so we optionally schedule another.
 	 */
-	priv->recalib_window = jiffies + msecs_to_jiffies(recal_guard_time);
+	if (recal_guard_time)
+		priv->recalib_window = jiffies +
+			msecs_to_jiffies(recal_guard_time);
 
 	return 0;
 }
@@ -898,8 +913,6 @@ static void hgpk_recalib_work(struct work_struct *work)
 	struct hgpk_data *priv = container_of(w, struct hgpk_data, recalib_wq);
 	struct psmouse *psmouse = priv->psmouse;
 
-	hgpk_dbg(psmouse, "recalibrating touchpad..\n");
-
 	if (hgpk_force_recalibrate(psmouse))
 		hgpk_err(psmouse, "recalibration failed!\n");
 }
-- 
1.7.3.2

