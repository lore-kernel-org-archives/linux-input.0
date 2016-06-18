From: Guohua Zhong <ghzhong@yifangdigital.com>
Subject: [PATCH] HID: i2c-hid: set power sleep before shutdown
Date: Sat, 18 Jun 2016 18:50:30 +0800
Message-ID: <1466247030-23047-1-git-send-email-ghzhong@yifangdigital.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.yifangdigital.com ([121.15.200.100]:4967 "EHLO
	yifangdigital.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751066AbcFRK6W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2016 06:58:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guohua Zhong <ghzhong@yifangdigital.com>

Add i2c_hid_shutdown for i2c-hid driver to send suspend cmd &
disable irq before device shutdown.

Some HW design is that the power to i2c hid device won't down
after device shutdown. Also the i2c-hid driver do not send suspend
cmd to the hid i2c device and disable its irq before shutdown.So
if We touch the touchscreen or some other i2c hid device ,the power
consumtion will be go up even when the device is in shutdown state.

Though the root cause maybe a HW issue. But it seems that it is a
good pratice to set power sleep for i2c-hid device before shutdown.

Signed-off-by: Guohua Zhong <ghzhong@yifangdigital.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 2e021ba..d6ea97b 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1106,6 +1106,12 @@ static int i2c_hid_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void i2c_hid_shutdown(struct i2c_client *client)
+{
+	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+	disable_irq(client->irq);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int i2c_hid_suspend(struct device *dev)
 {
@@ -1230,7 +1236,7 @@ static struct i2c_driver i2c_hid_driver = {
 
 	.probe		= i2c_hid_probe,
 	.remove		= i2c_hid_remove,
-
+	.shutdown	= i2c_hid_shutdown,
 	.id_table	= i2c_hid_id_table,
 };
 
-- 
1.9.1


