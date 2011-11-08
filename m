From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH] Input: elantech: adjust hw_version detection logic
Date: Tue,  8 Nov 2011 20:08:19 +0800
Message-ID: <1320754099-2669-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:22132 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab1KHMKv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 07:10:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, JJ Ding <jj_ding@emc.com.tw>

This patch fixes some v3 hardware (fw_version: 0x150500) wrongly detected
as v2 hardware.

Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
---
Hi list,

This is patched against v3.2-rc1.

Marc, could you please test this again? Thanks a lot.

br,
jj

 drivers/input/mouse/elantech.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 09b93b1..e2a9867 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1210,18 +1210,28 @@ static int elantech_reconnect(struct psmouse *psmouse)
  */
 static int elantech_set_properties(struct elantech_data *etd)
 {
+	/* This represents the version of IC body. */
 	int ver = (etd->fw_version & 0x0f0000) >> 16;
 
+	/* Early version of Elan touchpads doesn't obey the rule. */
 	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
 		etd->hw_version = 1;
-	else if (etd->fw_version < 0x150600)
-		etd->hw_version = 2;
-	else if (ver == 5)
-		etd->hw_version = 3;
-	else if (ver == 6)
-		etd->hw_version = 4;
-	else
-		return -1;
+	else {
+		switch (ver) {
+		case 2:
+		case 4:
+			etd->hw_version = 2;
+			break;
+		case 5:
+			etd->hw_version = 3;
+			break;
+		case 6:
+			etd->hw_version = 4;
+			break;
+		default:
+			return -1;
+		}
+	}
 
 	/*
 	 * Turn on packet checking by default.
-- 
1.7.8.rc1

