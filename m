From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] alps: Report bare packets coming from alps_handle_interleaved_ps2 via dev3
Date: Wed,  1 Apr 2015 17:44:05 +0200
Message-ID: <1427903046-26692-2-git-send-email-hdegoede@redhat.com>
References: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58017 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbbDAPoM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Apr 2015 11:44:12 -0400
In-Reply-To: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Bare packets should be reported via the same evdev device independent on
whether they are detected on the beginning of a packet or in the middle
of a packet.

This has been tested on a Dell Latitude E6400, where the DualPoint Stick
reports bare packets, which when the touchpad is idle get reported via
dev3, and when the touchpad ans tick are used simulateniously via dev2.

This commit fixes this inconsistency by always reporting bare packets via
dev3. Note that since the come from a DualPoint Stick they really should be
reported via dev2, this gets fixed in a later commit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 1bd15eb..f2c5545 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1154,10 +1154,23 @@ out:
 	mutex_unlock(&alps_mutex);
 }
 
-static void alps_report_bare_ps2_packet(struct input_dev *dev,
+static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 					unsigned char packet[],
 					bool report_buttons)
 {
+	struct alps_data *priv = psmouse->private;
+	struct input_dev *dev;
+
+	if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+		/* Register dev3 mouse if we received PS/2 packet first time */
+		if (!IS_ERR(priv->dev3))
+			psmouse_queue_work(psmouse, &priv->dev3_register_work,
+					   0);
+		return;
+	} else {
+		dev = priv->dev3;
+	}
+
 	if (report_buttons)
 		alps_report_buttons(dev, NULL,
 				packet[0] & 1, packet[0] & 2, packet[0] & 4);
@@ -1232,8 +1245,8 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 		 * de-synchronization.
 		 */
 
-		alps_report_bare_ps2_packet(priv->dev2,
-					    &psmouse->packet[3], false);
+		alps_report_bare_ps2_packet(psmouse, &psmouse->packet[3],
+					    false);
 
 		/*
 		 * Continue with the standard ALPS protocol handling,
@@ -1289,18 +1302,9 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 	 * properly we only do this if the device is fully synchronized.
 	 */
 	if (!psmouse->out_of_sync_cnt && (psmouse->packet[0] & 0xc8) == 0x08) {
-
-		/* Register dev3 mouse if we received PS/2 packet first time */
-		if (unlikely(!priv->dev3))
-			psmouse_queue_work(psmouse,
-					   &priv->dev3_register_work, 0);
-
 		if (psmouse->pktcnt == 3) {
-			/* Once dev3 mouse device is registered report data */
-			if (likely(!IS_ERR_OR_NULL(priv->dev3)))
-				alps_report_bare_ps2_packet(priv->dev3,
-							    psmouse->packet,
-							    true);
+			alps_report_bare_ps2_packet(psmouse, psmouse->packet,
+						    true);
 			return PSMOUSE_FULL_PACKET;
 		}
 		return PSMOUSE_GOOD_DATA;
-- 
2.3.4

