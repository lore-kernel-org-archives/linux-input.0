From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH] Input: trackpoint - use psmouse_fmt() for messages
Date: Tue, 20 Mar 2012 16:24:58 +0800
Message-ID: <1332231898-15531-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:16410 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759167Ab2CTIeK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 04:34:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: JJ Ding <jj_ding@emc.com.tw>, JJ Ding <dgdunix@gmail.com>

From: JJ Ding <dgdunix@gmail.com>

Use psmouse_*() macros introduced in commit b5d21704361ee.

Signed-off-by: JJ Ding <dgdunix@gmail.com>
---
 drivers/input/mouse/trackpoint.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 22b2180..3cd240e 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -304,7 +304,7 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 		return 0;
 
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
-		printk(KERN_WARNING "trackpoint.c: failed to get extended button data\n");
+		psmouse_warn(psmouse, "failed to get extended button data\n");
 		button_info = 0;
 	}
 
@@ -326,15 +326,14 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 
 	error = sysfs_create_group(&ps2dev->serio->dev.kobj, &trackpoint_attr_group);
 	if (error) {
-		printk(KERN_ERR
-			"trackpoint.c: failed to create sysfs attributes, error: %d\n",
-			error);
+		psmouse_err(psmouse,
+			"failed to create sysfs attributes, error: %d\n", error);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 		return -1;
 	}
 
-	printk(KERN_INFO "IBM TrackPoint firmware: 0x%02x, buttons: %d/%d\n",
+	psmouse_info(psmouse, "IBM TrackPoint firmware: 0x%02x, buttons: %d/%d\n",
 		firmware_id, (button_info & 0xf0) >> 4, button_info & 0x0f);
 
 	return 0;
-- 
1.7.10.rc1

