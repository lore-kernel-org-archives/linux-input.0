From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] Input: goodix - Support interchanging x and y coordinates in hardware
Date: Thu, 20 Oct 2016 14:59:17 -0500
Message-ID: <20161020195917.20051-5-fcooper@ti.com>
References: <20161020195917.20051-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161020195917.20051-1-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org, octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On systems with a fixed display/touchscreen orientation it is important to
pass in the "correct" x and y coordinates based on the orientation.
Currently, to support landscape and portrait touchscreen-swapped-x-y
simply does the following:

Assuming touchscreen is as follows:
X: 1280 Y:800 programmed in touchscreen controller and also interchange
bit cleared. Assuming ts mounted in portrait mode.

1280 (X)
------
|    |
|    | 800 (Y)
|    |
|    |
------

800 (Y)
------
|    |
|    | 1280 (X)
|    |
|    |
------

However, the above isn't really what we want especially in distros that
assumes a fixed orientation. In this case what we really want is to
interchange the x and y coordinates so the Y coordinate can return a max
value of 1280 and X can return a max value of 800.

800 (X)
------
|    |
|    | 1280 (Y)
|    |
|    |
------

Since the driver is limited to the value reported by the touchscreen
controller this issue can't be fixed purely in the driver. Therefore,
add a new DT property that supports interchanging X and Y coordinates
internally within the hardware.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/input/touchscreen/goodix.txt        |  2 ++
 drivers/input/touchscreen/goodix.c                          | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index ebc7cb7..b8be2ab 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -25,6 +25,8 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - touchscreen-inter-x-y   : X and Y maximum values programmed in the device
+                             are interchanged internally in hardware. (boolean)
 
 Example:
 
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index c2428e1..3f93375 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -39,6 +39,7 @@ struct goodix_ts_data {
 	bool swapped_x_y;
 	bool inverted_x;
 	bool inverted_y;
+	bool interchange_x_y;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
 	int cfg_len;
@@ -76,6 +77,9 @@ struct goodix_ts_data {
 #define MAX_CONTACTS_LOC	5
 #define TRIGGER_LOC		6
 
+/* Register Bits */
+#define XY_COORD_INTER		3
+
 static const unsigned long goodix_irq_flags[] = {
 	IRQ_TYPE_EDGE_RISING,
 	IRQ_TYPE_EDGE_FALLING,
@@ -500,6 +504,10 @@ static void goodix_tweak_config(struct goodix_ts_data *ts)
 	put_unaligned_le16(ts->abs_x_max, &config[RESOLUTION_LOC]);
 	put_unaligned_le16(ts->abs_y_max, &config[RESOLUTION_LOC + 2]);
 
+	if (ts->interchange_x_y)
+		config[TRIGGER_LOC] = config[TRIGGER_LOC] |
+				      (1 << XY_COORD_INTER);
+
 	check_sum = goodix_calculate_checksum(ts->cfg_len, config);
 
 	config[raw_cfg_len] = check_sum;
@@ -700,6 +708,11 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
 		}
 	}
 
+	ts->interchange_x_y = device_property_read_bool(&ts->client->dev,
+						    "touchscreen-inter-x-y");
+	if (ts->interchange_x_y)
+		alter_config = true;
+
 	if (alter_config)
 		goodix_tweak_config(ts);
 
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
