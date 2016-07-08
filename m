From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] hid: hid-led: fix Delcom support on big endian systems
Date: Fri, 8 Jul 2016 06:58:37 +0200
Message-ID: <c65d7daa-e057-8aab-7e3e-2e88bf896061@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34693 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbcGHE6w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 00:58:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id w75so1660073wmd.1
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2016 21:58:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Properly handle this __le16 value on big endian systems.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 4c43ef8..d8d55f3 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -327,7 +327,7 @@ static int delcom_init(struct hidled_device *ldev)
 	 * Several Delcom devices share the same USB VID/PID
 	 * Check for family id 2 for Visual Signal Indicator
 	 */
-	return dp.fw.family_code == 2 ? 0 : -ENODEV;
+	return le16_to_cpu(dp.fw.family_code) == 2 ? 0 : -ENODEV;
 }
 
 static int luxafor_write(struct led_classdev *cdev, enum led_brightness br)
-- 
2.9.0

