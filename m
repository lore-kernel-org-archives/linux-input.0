From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] hid: thingm: remove not needed error message
Date: Wed, 20 Apr 2016 20:33:05 +0200
Message-ID: <5717CB61.3080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35917 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcDTSdU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2016 14:33:20 -0400
Received: by mail-wm0-f49.google.com with SMTP id v188so214940854wme.1
        for <linux-input@vger.kernel.org>; Wed, 20 Apr 2016 11:33:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

LED core takes care of handling failed calls to thingm_let_set.
- print error message in set_brightness_delayed or
- pass error to caller in led_set_brightness_sync
Also the error message here doesn't provide any hint what actually
went wrong. Therefore remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 2507bbe..9ad9c6e 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -148,13 +148,8 @@ static int thingm_led_set(struct led_classdev *ldev,
 			  enum led_brightness brightness)
 {
 	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
-	int ret;
-
-	ret = thingm_write_color(led->rgb);
-	if (ret)
-		hid_err(led->rgb->tdev->hdev, "failed to write color\n");
 
-	return ret;
+	return thingm_write_color(led->rgb);
 }
 
 static int thingm_init_led(struct thingm_led *led, const char *color_name,
-- 
2.8.0

