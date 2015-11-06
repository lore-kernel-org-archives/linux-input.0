From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Input: elantech - add Fujitsu Lifebook U745 to force crc_enabled
Date: Fri,  6 Nov 2015 20:01:25 +0100
Message-ID: <1446836485-1006-1-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40271 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754611AbbKFTB3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Nov 2015 14:01:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Another Lifebook machine that needs the same quirk as other similar
models to make the driver working.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=883192
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/mouse/elantech.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2955f1d0ca6c..537ebb0e193a 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1520,6 +1520,13 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
 		},
 	},
+	{
+		/* Fujitsu LIFEBOOK U745 does not work with crc_enabled == 0 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
+		},
+	},
 #endif
 	{ }
 };
-- 
2.6.2

