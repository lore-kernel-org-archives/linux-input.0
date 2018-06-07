From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Input: goodix - Add "GDIX1002" ACPI HID
Date: Thu,  7 Jun 2018 11:36:40 +0200
Message-ID: <20180607093640.8103-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some newer devices with a goodix touchscreen use GDIX1002 as ACPI HID
rather then GDIX1001. These devices work fine with the goodix driver
as is.

This commit adds the new "GDIX1002" ACPI HID to make the touchscreen
work on these devices.

Buglink: https://www.reddit.com/r/gpdwin/comments/8lwy8n/gpd_win_2_linux_touchscreen_fix/
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 9736c83dd418..f2d9c2c41885 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -933,6 +933,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id goodix_acpi_match[] = {
 	{ "GDIX1001", 0 },
+	{ "GDIX1002", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
-- 
2.17.1
