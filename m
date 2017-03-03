From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH v2 1/2] HID: cp2112: use proper hidraw name with minor number
Date: Fri,  3 Mar 2017 17:54:00 +0900
Message-ID: <1488531241-18367-2-git-send-email-climbbb.kim@gmail.com>
References: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: linux-input@vger.kernel.org

The cp2112 driver is working on hidraw not hiddev. So we need to use proper
hidraw name with hidraw's minor number.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
Changes in v2:
- tie in a series
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
