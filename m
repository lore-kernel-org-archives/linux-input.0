From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH 2/2] Input: elantech - remove module parameter force_elantech
Date: Tue, 13 Sep 2011 14:15:49 +0800
Message-ID: <1315894549-24504-3-git-send-email-jj_ding@emc.com.tw>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:10390 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab1IMGNY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 02:13:24 -0400
In-Reply-To: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Richard=20Sch=C3=BCtz?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <jj_ding@emc.com.tw>

This essentially reverts commit f81bc788ff91d4efd4baf88b2c29713838caa8e5.

With recent work on elantech driver, I believe we now have complete support
for all elantech touchpads. So remove this hack.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
---
 drivers/input/mouse/elantech.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 63a0ce7..ea8cdcf 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -28,10 +28,6 @@
 			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 	} while (0)
 
-static bool force_elantech;
-module_param_named(force_elantech, force_elantech, bool, 0644);
-MODULE_PARM_DESC(force_elantech, "Force the Elantech PS/2 protocol extension to be used, 1 = enabled, 0 = disabled (default).");
-
 /*
  * Send a Synaptics style sliced query command
  */
@@ -1163,12 +1159,8 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 		 param[0], param[1], param[2]);
 
 	if (!elantech_is_signature_valid(param)) {
-		if (!force_elantech) {
-			pr_debug("Probably not a real Elantech touchpad. Aborting.\n");
-			return -1;
-		}
-
-		pr_debug("Probably not a real Elantech touchpad. Enabling anyway due to force_elantech.\n");
+		pr_debug("Probably not a real Elantech touchpad. Aborting.\n");
+		return -1;
 	}
 
 	if (set_properties) {
-- 
1.7.4.1

