From: Guohua Zhong <ghzhong@yifangdigital.com>
Subject: [PATCH v2] HID: i2c-hid: set power sleep before shutdown
Date: Tue, 21 Jun 2016 18:27:45 +0800
Message-ID: <1466504865-19907-1-git-send-email-ghzhong@yifangdigital.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guohua Zhong <ghzhong@yifangdigital.com>
List-Id: linux-input@vger.kernel.org

Add i2c_hid_shutdown for i2c-hid driver to send suspend cmd & free
irq before device shutdown.

Some HW design (i.e. Umaro, a chromebook model) is that the power to
i2c hid device won't down after device shutdown. Also the i2c-hid driver
do not send suspend cmd to the hid i2c device and free its irq before
shutdown.So if We touch the touchscreen or some other i2c hid device,
the power consumtion will be go up even when the device is in shutdown
state.

Though the root cause maybe a HW issue. But it seems that it is a
good pratice to set power sleep for i2c-hid device before shutdown.

Signed-off-by: Guohua Zhong <ghzhong@yifangdigital.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 2e021ba..79406ae 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1106,6 +1106,14 @@ static int i2c_hid_remove(struct i2c_client *client)
 	return 0;
 }
 
+static void i2c_hid_shutdown(struct i2c_client *client)
+{
+	struct i2c_hid *ihid = i2c_get_clientdata(client);
+
+	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+	free_irq(client->irq, ihid);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int i2c_hid_suspend(struct device *dev)
 {
@@ -1230,7 +1238,7 @@ static struct i2c_driver i2c_hid_driver = {
 
 	.probe		= i2c_hid_probe,
 	.remove		= i2c_hid_remove,
-
+	.shutdown	= i2c_hid_shutdown,
 	.id_table	= i2c_hid_id_table,
 };
 
-- 
1.9.1
