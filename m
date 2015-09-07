From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 8/9] Input: goodix - add sysfs interface to dump config
Date: Mon,  7 Sep 2015 17:36:22 +0300
Message-ID: <1441636583-14188-9-git-send-email-irina.tirdea@intel.com>
References: <1441636583-14188-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441636583-14188-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 33a7b81..3179767 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -530,12 +530,35 @@ static ssize_t goodix_esd_timeout_store(struct device *dev,
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
