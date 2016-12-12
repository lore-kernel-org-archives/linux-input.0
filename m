From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ar1021-i2c - fix too long name in driver's device
 table
Date: Mon, 12 Dec 2016 15:57:02 -0800
Message-ID: <20161212235702.GA10843@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32848 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcLLX5G (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 18:57:06 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, m.frohiky@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>

The name field in structure i2c_device_id is 20 characters, and we
expect it to be NULL-terminated, however we are trying to stuff it with
21 bytes and thus NULL-terminator is lost. This causes issues when one
creates device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the
last "C", and automatic module loading by alias does not work as result.

The -I2C suffix in the device name is superfluous, we know what bus we
are dealing with, so let's drop it.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116211
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ar1021_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 71b5a63..89f9587 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -152,7 +152,7 @@ static int __maybe_unused ar1021_i2c_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
 
 static const struct i2c_device_id ar1021_i2c_id[] = {
-	{ "MICROCHIP_AR1021_I2C", 0 },
+	{ "MICROCHIP_AR1021", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
