From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 5/6] hwmon: da9052: replace S_IRUGO with 0444
Date: Mon,  3 Jul 2017 10:40:02 +0200
Message-ID: <20170703084003.31184-6-sebastian.reichel@collabora.co.uk>
References: <20170703084003.31184-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20170703084003.31184-1-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Fix checkpatch warnings about S_IRUGO being less readable than
providing the permissions octal as '0444'.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/hwmon/da9052-hwmon.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index c9832bfacfe5..708c91ac601f 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -196,43 +196,43 @@ static ssize_t show_label(struct device *dev,
 		       input_names[to_sensor_dev_attr(devattr)->index]);
 }
 
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9052_read_vddout, NULL,
+static SENSOR_DEVICE_ATTR(in0_input, 0444, da9052_read_vddout, NULL,
 			  DA9052_ADC_VDDOUT);
-static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(in0_label, 0444, show_label, NULL,
 			  DA9052_ADC_VDDOUT);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, da9052_read_vbat, NULL,
+static SENSOR_DEVICE_ATTR(in3_input, 0444, da9052_read_vbat, NULL,
 			  DA9052_ADC_VBAT);
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(in3_label, 0444, show_label, NULL,
 			  DA9052_ADC_VBAT);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, da9052_read_misc_channel, NULL,
+static SENSOR_DEVICE_ATTR(in4_input, 0444, da9052_read_misc_channel, NULL,
 			  DA9052_ADC_IN4);
-static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(in4_label, 0444, show_label, NULL,
 			  DA9052_ADC_IN4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, da9052_read_misc_channel, NULL,
+static SENSOR_DEVICE_ATTR(in5_input, 0444, da9052_read_misc_channel, NULL,
 			  DA9052_ADC_IN5);
-static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(in5_label, 0444, show_label, NULL,
 			  DA9052_ADC_IN5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, da9052_read_misc_channel, NULL,
+static SENSOR_DEVICE_ATTR(in6_input, 0444, da9052_read_misc_channel, NULL,
 			  DA9052_ADC_IN6);
-static SENSOR_DEVICE_ATTR(in6_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(in6_label, 0444, show_label, NULL,
 			  DA9052_ADC_IN6);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, da9052_read_vbbat, NULL,
+static SENSOR_DEVICE_ATTR(in9_input, 0444, da9052_read_vbbat, NULL,
 			  DA9052_ADC_VBBAT);
-static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(in9_label, 0444, show_label, NULL,
 			  DA9052_ADC_VBBAT);
 
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, da9052_read_ich, NULL,
+static SENSOR_DEVICE_ATTR(curr1_input, 0444, da9052_read_ich, NULL,
 			  DA9052_ADC_ICH);
-static SENSOR_DEVICE_ATTR(curr1_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(curr1_label, 0444, show_label, NULL,
 			  DA9052_ADC_ICH);
 
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, da9052_read_tbat, NULL,
+static SENSOR_DEVICE_ATTR(temp2_input, 0444, da9052_read_tbat, NULL,
 			  DA9052_ADC_TBAT);
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(temp2_label, 0444, show_label, NULL,
 			  DA9052_ADC_TBAT);
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, da9052_read_tjunc, NULL,
+static SENSOR_DEVICE_ATTR(temp8_input, 0444, da9052_read_tjunc, NULL,
 			  DA9052_ADC_TJUNC);
-static SENSOR_DEVICE_ATTR(temp8_label, S_IRUGO, show_label, NULL,
+static SENSOR_DEVICE_ATTR(temp8_label, 0444, show_label, NULL,
 			  DA9052_ADC_TJUNC);
 
 static struct attribute *da9052_attrs[] = {
-- 
2.11.0

