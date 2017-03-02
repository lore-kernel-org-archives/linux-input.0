From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH] HID: cp2112: use proper hidraw name with minor number
Date: Thu,  2 Mar 2017 22:27:58 +0900
Message-ID: <1488461278-8870-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34468 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdCBOCQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Mar 2017 09:02:16 -0500
Received: by mail-pf0-f196.google.com with SMTP id x66so6839221pfb.1
        for <linux-input@vger.kernel.org>; Thu, 02 Mar 2017 06:00:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>

The cp2112 driver is working on hidraw not hiddev. So we need to use proper
hidraw name with hidraw's minor number.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/hid/hid-cp2112.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index b22d0f8..078026f 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -27,6 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/hid.h>
+#include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/nls.h>
@@ -1297,7 +1298,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->adap.algo_data	= dev;
 	dev->adap.dev.parent	= &hdev->dev;
 	snprintf(dev->adap.name, sizeof(dev->adap.name),
-		 "CP2112 SMBus Bridge on hiddev%d", hdev->minor);
+		 "CP2112 SMBus Bridge on hidraw%d",
+		 ((struct hidraw *)hdev->hidraw)->minor);
 	dev->hwversion = buf[2];
 	init_waitqueue_head(&dev->wait);
 
-- 
2.7.4

