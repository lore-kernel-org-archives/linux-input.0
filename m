From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/2] hid: thingm: set new flag LED_HW_PLUGGABLE
Date: Sun, 17 Apr 2016 22:51:46 +0200
Message-ID: <5713F762.5070409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34665 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbcDQUwC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Apr 2016 16:52:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id n3so19755830wmn.1
        for <linux-input@vger.kernel.org>; Sun, 17 Apr 2016 13:52:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Use recently introduced flag LED_HW_PLUGGABLE to avoid warnings when
the device is unplugged.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index a90463e..2507bbe 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -165,6 +165,7 @@ static int thingm_init_led(struct thingm_led *led, const char *color_name,
 	led->ldev.name = led->name;
 	led->ldev.max_brightness = 255;
 	led->ldev.brightness_set_blocking = thingm_led_set;
+	led->ldev.flags = LED_HW_PLUGGABLE;
 	led->rgb = rgb;
 	return devm_led_classdev_register(&rgb->tdev->hdev->dev, &led->ldev);
 }
-- 
2.8.0

