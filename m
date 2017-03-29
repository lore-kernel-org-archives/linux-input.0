From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH] HID: wacom: Bamboo One Medium does not have touch
Date: Wed, 29 Mar 2017 13:07:36 -0700
Message-ID: <1490818056-9841-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33461 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbdC2UJA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 16:09:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so4422283pgf.0
        for <linux-input@vger.kernel.org>; Wed, 29 Mar 2017 13:08:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Commit 3b164a00a9fc ("HID: wacom: Cleanup unsupported device_type
for BAMBOO_PT") cleaned up Bamboo devices which our driver falsely
claimed had touch. Bamboo One Medium also does not have touch.

Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
This bug does not change functionality, but made recent bugs
more difficult to track down. This should be fine for next/4.12.

 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4aa3de9f1163..ffd891c1ca64 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4115,7 +4115,7 @@ static const struct wacom_features wacom_features_0x300 =
 	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x301 =
 	{ "Wacom Bamboo One M", 21648, 13530, 1023, 31,
-	  BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x302 =
 	{ "Wacom Intuos PT S", 15200, 9500, 1023, 31,
 	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, .touch_max = 16,
-- 
2.7.4

