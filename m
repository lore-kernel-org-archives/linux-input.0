From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 3/4] Input: goodix - Tweak configuration to use passed in touchscreen resolution
Date: Thu, 20 Oct 2016 14:59:16 -0500
Message-ID: <20161020195917.20051-4-fcooper@ti.com>
References: <20161020195917.20051-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020195917.20051-1-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, hadess@hadess.net, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-input@vger.kernel.org

Some goodix touchscreen controllers aren't programed properly to match the
display panel it is used on. Although the defaults may largely work it is
also likely that the screen resolution will be incorrect. Therefore,
add support to allow via DT for the touchscreen resolution to be set and
reprogram the controller to use this updated resolution.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 .../bindings/input/touchscreen/goodix.txt          |  2 ++
 drivers/input/touchscreen/goodix.c                 | 26 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index c98757a..ebc7cb7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -19,6 +19,8 @@ Optional properties:
 			  interrupt gpio pin as output to reset the device.
  - reset-gpios		: GPIO pin used for reset
 
+ - touchscreen-size-x      : horizontal resolution of touchscreen (in pixels)
+ - touchscreen-size-y      : vertical resolution of touchscreen (in pixels)
  - touchscreen-inverted-x  : X axis is inverted (boolean)
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 01e12f8..c2428e1 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -496,6 +496,10 @@ static void goodix_tweak_config(struct goodix_ts_data *ts)
 		return;
 	}
 
+	/* Setting X and Y Resolution */
+	put_unaligned_le16(ts->abs_x_max, &config[RESOLUTION_LOC]);
+	put_unaligned_le16(ts->abs_y_max, &config[RESOLUTION_LOC + 2]);
+
 	check_sum = goodix_calculate_checksum(ts->cfg_len, config);
 
 	config[raw_cfg_len] = check_sum;
@@ -669,6 +673,8 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 static int goodix_configure_dev(struct goodix_ts_data *ts)
 {
 	int error;
+	bool alter_config = false;
+	u32 max_x, max_y;
 
 	ts->swapped_x_y = device_property_read_bool(&ts->client->dev,
 						    "touchscreen-swapped-x-y");
@@ -676,9 +682,27 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
 						   "touchscreen-inverted-x");
 	ts->inverted_y = device_property_read_bool(&ts->client->dev,
 						   "touchscreen-inverted-y");
-
 	goodix_read_config(ts);
 
+	if (device_property_present(&ts->client->dev, "touchscreen-size-x") &&
+	    device_property_present(&ts->client->dev, "touchscreen-size-y")) {
+
+		device_property_read_u32(&ts->client->dev, "touchscreen-size-x",
+				&max_x);
+
+		device_property_read_u32(&ts->client->dev, "touchscreen-size-y",
+				&max_y);
+
+		if (max_x > 0 && max_y > 0) {
+			ts->abs_x_max = max_x;
+			ts->abs_y_max = max_y;
+			alter_config = true;
+		}
+	}
+
+	if (alter_config)
+		goodix_tweak_config(ts);
+
 	error = goodix_request_input_dev(ts);
 	if (error)
 		return error;
-- 
2.10.0
