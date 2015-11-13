From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: Add outbounding area for DTU1141
Date: Thu, 12 Nov 2015 17:21:14 -0800
Message-ID: <1447377674-16818-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34654 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbbKMBVQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2015 20:21:16 -0500
Received: by padhx2 with SMTP id hx2so82334019pad.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2015 17:21:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Ping Cheng <pingc@wacom.com>

DTU1141 has an extra 1 mm tablet active outbounding area on each
side of the display, same as those recently released DTUs.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9db6a8b..5d946bb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3187,7 +3187,8 @@ static const struct wacom_features wacom_features_0x32F =
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x336 =
 	{ "Wacom DTU1141", 23472, 13203, 1023, 0,
-	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4 };
+	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
+	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x57 =
 	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
 	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
-- 
1.9.1

