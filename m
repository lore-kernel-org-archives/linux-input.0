From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elantech - force a module ignore ABS mode
Date: Mon, 12 Dec 2016 15:11:03 +0800
Message-ID: <1481526663-2730-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:48479 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbcLLHJo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 02:09:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw

One Elan sample which sample version is 0x74 and hw_version is 0x04 has a bug in abs mode, so let it run in default mode
Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index db7d1d6..f1c2d10 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1687,6 +1687,13 @@ int elantech_init(struct psmouse *psmouse)
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
 
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		/*This module has a bug in absolute mode, let it be defualt mode  */
+		psmouse_info(psmouse,
+			     "This module only active in default mode\n");
+		goto init_fail;
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
-- 
2.7.4

