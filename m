From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 1/7] input/ti_am_335x_tsc: remove the else case
Date: Wed, 22 May 2013 23:08:11 +0200
Message-ID: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Patil Rachna <rachna-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The DT support added in ("input: touchscreen: am335x: Add DT support")
added an else case which shifts the code to the righ for no reaseon.
This patch simply removes the pointless else case and shifts the code
back to the left.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   63 +++++++++++++----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 4fcf72f..20f4505 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -396,41 +396,34 @@ static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
 
 	if (!node)
 		return -EINVAL;
-	else {
-		node = of_get_child_by_name(node, "tsc");
-		if (!node)
-			return -EINVAL;
-		else {
-			err = of_property_read_u32(node, "ti,wires", &val32);
-			if (err < 0)
-				goto error_ret;
-			else
-				ts_dev->wires = val32;
-
-			err = of_property_read_u32(node,
-					"ti,x-plate-resistance", &val32);
-			if (err < 0)
-				goto error_ret;
-			else
-				ts_dev->x_plate_resistance = val32;
-
-			err = of_property_read_u32(node,
-					"ti,steps-to-configure", &val32);
-			if (err < 0)
-				goto error_ret;
-			else
-				ts_dev->steps_to_configure = val32;
-
-			err = of_property_read_u32_array(node, "ti,wire-config",
-					wires_conf, ARRAY_SIZE(wires_conf));
-			if (err < 0)
-				goto error_ret;
-			else {
-				for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
-					ts_dev->config_inp[i] = wires_conf[i];
-			}
-		}
-	}
+
+	node = of_get_child_by_name(node, "tsc");
+	if (!node)
+		return -EINVAL;
+	err = of_property_read_u32(node, "ti,wires", &val32);
+	if (err < 0)
+		goto error_ret;
+	ts_dev->wires = val32;
+
+	err = of_property_read_u32(node,
+			"ti,x-plate-resistance", &val32);
+	if (err < 0)
+		goto error_ret;
+	ts_dev->x_plate_resistance = val32;
+
+	err = of_property_read_u32(node,
+			"ti,steps-to-configure", &val32);
+	if (err < 0)
+		goto error_ret;
+	ts_dev->steps_to_configure = val32;
+
+	err = of_property_read_u32_array(node, "ti,wire-config",
+			wires_conf, ARRAY_SIZE(wires_conf));
+	if (err < 0)
+		goto error_ret;
+
+	for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
+		ts_dev->config_inp[i] = wires_conf[i];
 	return 0;
 
 error_ret:
-- 
1.7.10.4
