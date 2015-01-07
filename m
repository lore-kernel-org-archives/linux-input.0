From: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: [PATCH 1/2] Input: adxl34x - add OF support
Date: Tue,  6 Jan 2015 23:58:56 -0300
Message-ID: <1420599537-28740-1-git-send-email-walter@vanguardiasur.com.ar>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch adds the missing support for OF to the adxl34x digital
accelerometer. This is a basic version which supports the main
optional parameters. This implementation copies the default values
to the adxl34x_platform_data structure and overrides the values
that are passed from the device tree.

Signed-off-by: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
---
 drivers/input/misc/adxl34x.c |  108 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 2b2d02f..b3e06a3 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -16,6 +16,8 @@
 #include <linux/workqueue.h>
 #include <linux/input/adxl34x.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "adxl34x.h"
 
@@ -688,13 +690,113 @@ static void adxl34x_input_close(struct input_dev *input)
 	mutex_unlock(&ac->mutex);
 }
 
+void adxl34x_parse_dt(struct device *dev, struct adxl34x_platform_data *pdata){
+	if (!dev->of_node)
+		return;
+
+	pdata =  kzalloc(sizeof(*pdata), GFP_KERNEL);
+
+	memcpy(pdata, &adxl34x_default_init, sizeof(struct adxl34x_platform_data));
+
+	of_property_read_u8(dev->of_node, "adi,tap-axis-control",
+		 &pdata->tap_axis_control);
+
+	of_property_read_u8(dev->of_node, "adi,tap-threshold",
+		 &pdata->tap_threshold);
+
+	of_property_read_u8(dev->of_node, "adi,tap-duration",
+		 &pdata->tap_duration);
+
+	of_property_read_u8(dev->of_node, "adi,tap-latency",
+		 &pdata->tap_latency);
+
+	of_property_read_u8(dev->of_node, "adi,tap-window",
+		 &pdata->tap_window);
+
+	of_property_read_u8(dev->of_node, "adi,act-axis-control",
+		 &pdata->act_axis_control);
+
+	of_property_read_u8(dev->of_node, "adi,activity-threshold",
+		 &pdata->activity_threshold);
+
+	of_property_read_u8(dev->of_node, "adi,inactivity-threshold",
+		 &pdata->inactivity_threshold);
+
+	of_property_read_u8(dev->of_node, "adi,inactivity-time",
+		 &pdata->inactivity_time);
+
+	of_property_read_u8(dev->of_node, "adi,free-fall-threshold",
+		 &pdata->free_fall_threshold);
+
+	of_property_read_u8(dev->of_node, "adi,free-fall-time",
+		 &pdata->free_fall_time);
+
+	of_property_read_u8(dev->of_node, "adi,data-rate",
+		 &pdata->data_rate);
+
+	of_property_read_u8(dev->of_node, "adi,data-range",
+		 &pdata->data_range);
+
+	of_property_read_u8(dev->of_node, "adi,low-power-mode",
+		 &pdata->low_power_mode);
+
+	of_property_read_u8(dev->of_node, "adi,power-mode",
+		 &pdata->power_mode);
+
+	of_property_read_u8(dev->of_node, "adi,fifo-mode",
+		 &pdata->fifo_mode);
+
+	of_property_read_u8(dev->of_node, "adi,watermark",
+		 &pdata->watermark);
+
+	of_property_read_u8(dev->of_node, "adi,use-int2",
+		 &pdata->use_int2);
+
+	of_property_read_u8(dev->of_node, "adi,orientation-enable",
+		 &pdata->orientation_enable);
+
+	of_property_read_u8(dev->of_node, "adi,deadzone-angle",
+		 &pdata->deadzone_angle);
+
+	of_property_read_u8(dev->of_node, "adi,divisor-length",
+		 &pdata->divisor_length);
+
+	of_property_read_u32(dev->of_node, "adi,ev-type",
+		 &pdata->ev_type);
+
+	of_property_read_u32(dev->of_node, "adi,ev-code-x",
+		 &pdata->ev_code_x);
+
+	of_property_read_u32(dev->of_node, "adi,ev-code-y",
+		 &pdata->ev_code_y);
+
+	of_property_read_u32(dev->of_node, "adi,ev-code-z",
+		 &pdata->ev_code_z);
+
+	of_property_read_u32_array(dev->of_node, "adi,ev-code-tap",
+		 pdata->ev_code_tap, 3);
+
+	of_property_read_u32(dev->of_node, "adi,ev-code-ff",
+		 &pdata->ev_code_ff);
+
+	of_property_read_u32(dev->of_node, "adi,ev-code-act-inactivity",
+		 &pdata->ev_code_act_inactivity);
+
+	of_property_read_u32_array(dev->of_node, "adi,ev-codes-orient-2d",
+		 pdata->ev_codes_orient_2d, 4);
+
+	of_property_read_u32_array(dev->of_node, "adi,ev-codes-orient-3d",
+		 pdata->ev_codes_orient_3d, 6);
+
+}
+
 struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 			      bool fifo_delay_default,
 			      const struct adxl34x_bus_ops *bops)
 {
 	struct adxl34x *ac;
 	struct input_dev *input_dev;
-	const struct adxl34x_platform_data *pdata;
+	struct adxl34x_platform_data *pdata;
 	int err, range, i;
 	unsigned char revid;
 
@@ -714,6 +816,10 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 	ac->fifo_delay = fifo_delay_default;
 
 	pdata = dev_get_platdata(dev);
+
+	if (!pdata && dev->of_node)
+		adxl34x_parse_dt(dev, pdata);
+
 	if (!pdata) {
 		dev_dbg(dev,
 			"No platform data: Using default initialization\n");
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
