From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v5 1/4] i2c: add a protocol parameter to the alert callback
Date: Tue, 15 Mar 2016 15:53:41 +0100
Message-ID: <1458053624-14818-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1458053624-14818-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1458053624-14818-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

.alert() is meant to be generic, but there is currently no way
for the device driver to know which protocol generated the alert.
Add a parameter in .alert() to help the device driver to understand
what is given in data.

This patch is required to have the support of SMBus Host Notify protocol
through .alert().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 6 +++++-
 drivers/hwmon/lm90.c          | 3 ++-
 drivers/i2c/i2c-smbus.c       | 3 ++-
 include/linux/i2c.h           | 7 ++++++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 5f1c3d0..84d07bc 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -568,12 +568,16 @@ static void retry_timeout(unsigned long data)
 }
 
 
-static void ssif_alert(struct i2c_client *client, unsigned int data)
+static void ssif_alert(struct i2c_client *client,
+		       enum i2c_alert_protocol protocol, unsigned int data)
 {
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
 	unsigned long oflags, *flags;
 	bool do_get = false;
 
+	if (protocol != I2C_PROTOCOL_SMBUS_ALERT)
+		return;
+
 	ssif_inc_stat(ssif_info, alerts);
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c9ff08d..2b77dbd 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1624,7 +1624,8 @@ static int lm90_remove(struct i2c_client *client)
 	return 0;
 }
 
-static void lm90_alert(struct i2c_client *client, unsigned int flag)
+static void lm90_alert(struct i2c_client *client, enum i2c_alert_protocol type,
+		       unsigned int flag)
 {
 	u16 alarms;
 
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index abb55d3..3b6765a 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -56,7 +56,8 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
 		if (driver->alert)
-			driver->alert(client, data->flag);
+			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT,
+				      data->flag);
 		else
 			dev_warn(&client->dev, "no driver alert()!\n");
 	} else
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 200cf13b..baae02a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -126,6 +126,10 @@ i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 					  u8 command, u8 length, u8 *values);
 #endif /* I2C */
 
+enum i2c_alert_protocol {
+	I2C_PROTOCOL_SMBUS_ALERT,
+};
+
 /**
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
@@ -181,7 +185,8 @@ struct i2c_driver {
 	 * For the SMBus alert protocol, there is a single bit of data passed
 	 * as the alert response's low bit ("event flag").
 	 */
-	void (*alert)(struct i2c_client *, unsigned int data);
+	void (*alert)(struct i2c_client *, enum i2c_alert_protocol protocol,
+		      unsigned int data);
 
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
-- 
2.5.0

