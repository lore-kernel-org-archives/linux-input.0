From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v9 7/9] Input: goodix - add sysfs interface to dump config
Date: Mon, 12 Oct 2015 18:24:35 +0300
Message-ID: <1444663477-30062-8-git-send-email-irina.tirdea@intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Goodix devices have a configuration information register area that
specify various parameters for the device. The configuration information
has a specific format described in the Goodix datasheet. It includes X/Y
resolution, maximum supported touch points, interrupt flags, various
sesitivity factors and settings for advanced features (like gesture
recognition).

Export a sysfs interface that would allow reading the configuration
information. The default device configuration can be used as a starting
point for creating a valid configuration firmware used by the device at
init time to update its configuration.

This sysfs interface will be exported only if the gpio pins are properly
initialized from ACPI/DT.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Tested-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index a271df9..01a2634 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -508,12 +508,35 @@ static ssize_t goodix_esd_timeout_store(struct device *dev,
 	return count;
 }
 
+static ssize_t goodix_dump_config_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct goodix_ts_data *ts = dev_get_drvdata(dev);
+	u8 config[GOODIX_CONFIG_MAX_LENGTH];
+	int error, count = 0, i;
+
+	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
+				config, ts->cfg_len);
+	if (error) {
+		dev_warn(&ts->client->dev,
+			 "Error reading config (%d)\n",  error);
+		return error;
+	}
+
+	for (i = 0; i < ts->cfg_len; i++)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%02x ",
+				   config[i]);
+	return count;
+}
+
 /* ESD timeout in ms. Default disabled (0). Recommended 2000 ms. */
 static DEVICE_ATTR(esd_timeout, S_IRUGO | S_IWUSR, goodix_esd_timeout_show,
 		   goodix_esd_timeout_store);
+static DEVICE_ATTR(dump_config, S_IRUGO, goodix_dump_config_show, NULL);
 
 static struct attribute *goodix_attrs[] = {
 	&dev_attr_esd_timeout.attr,
+	&dev_attr_dump_config.attr,
 	NULL
 };
 
-- 
1.9.1
