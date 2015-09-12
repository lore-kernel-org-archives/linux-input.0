From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: edt-ft5x06 - use generic properties API
Date: Sat, 12 Sep 2015 10:45:49 -0700
Message-ID: <cad5ddbdef527ffaadaf25e9d54c7828a14beb4e.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-input@vger.kernel.org

Instead of only parsing device tree properties let's switch to using
generic properties API so that the driver can also work on other platforms.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 134c66c..ef8a7cd 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -808,20 +808,24 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	return 0;
 }
 
-#define EDT_GET_PROP(name, reg) {				\
-	u32 val;						\
-	if (of_property_read_u32(np, #name, &val) == 0)		\
-		edt_ft5x06_register_write(tsdata, reg, val);	\
-}
-
-static void edt_ft5x06_ts_get_defaults(struct device_node *np,
+static void edt_ft5x06_ts_get_defaults(struct device *dev,
 				       struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
+	u32 val;
+	int error;
+
+	error = device_property_read_u32(dev, "threshold", &val);
+	if (!error)
+		reg_addr->reg_threshold = val;
+
+	error = device_property_read_u32(dev, "gain", &val);
+	if (!error)
+		reg_addr->reg_gain = val;
 
-	EDT_GET_PROP(threshold, reg_addr->reg_threshold);
-	EDT_GET_PROP(gain, reg_addr->reg_gain);
-	EDT_GET_PROP(offset, reg_addr->reg_offset);
+	error = device_property_read_u32(dev, "offset", &val);
+	if (!error)
+		reg_addr->reg_offset = val;
 }
 
 static void
@@ -928,7 +932,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	}
 
 	edt_ft5x06_ts_set_regs(tsdata);
-	edt_ft5x06_ts_get_defaults(client->dev.of_node, tsdata);
+	edt_ft5x06_ts_get_defaults(&client->dev, tsdata);
 	edt_ft5x06_ts_get_parameters(tsdata);
 
 	dev_dbg(&client->dev,
-- 
2.6.0.rc0.131.gf624c3d
