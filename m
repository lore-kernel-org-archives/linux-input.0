From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 6/9] Input: pixcir_i2c_ts: Add chip specific data structure
Date: Wed, 18 Dec 2013 14:51:17 +0530
Message-ID: <1387358480-8313-7-git-send-email-rogerq@ti.com>
References: <1387358480-8313-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387358480-8313-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rydberg@euromail.se, jcbian@pixcir.com.cn, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-input@vger.kernel.org

This is the data that differentiates different pixcir
chips.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c |  8 +++++---
 include/linux/input/pixcir_ts.h           | 11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index a783d94..ff68246 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -32,7 +32,7 @@
 struct pixcir_i2c_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
-	const struct pixcir_ts_platform_data *chip;
+	const struct pixcir_ts_platform_data *pdata;
 	bool exiting;
 };
 
@@ -91,7 +91,7 @@ static void pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)
 static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
 {
 	struct pixcir_i2c_ts_data *tsdata = dev_id;
-	const struct pixcir_ts_platform_data *pdata = tsdata->chip;
+	const struct pixcir_ts_platform_data *pdata = tsdata->pdata;
 
 	while (!tsdata->exiting) {
 		pixcir_ts_poscheck(tsdata);
@@ -301,6 +301,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
+	pdata->chip = *(const struct pixcir_i2c_chip_data *)match->data;
+
 	pdata->gpio_attb = of_get_named_gpio(np, "attb-gpio", 0);
 	if (!gpio_is_valid(pdata->gpio_attb)) {
 		dev_err(dev, "Failed to get ATTB GPIO\n");
@@ -366,7 +368,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 
 	tsdata->client = client;
 	tsdata->input = input;
-	tsdata->chip = pdata;
+	tsdata->pdata = pdata;
 
 	input->name = client->name;
 	input->id.bustype = BUS_I2C;
diff --git a/include/linux/input/pixcir_ts.h b/include/linux/input/pixcir_ts.h
index 88ffdb50..b9a2f6f 100644
--- a/include/linux/input/pixcir_ts.h
+++ b/include/linux/input/pixcir_ts.h
@@ -43,10 +43,21 @@ enum pixcir_int_mode {
 #define PIXCIR_INT_ENABLE	(1UL << 3)
 #define PIXCIR_INT_POL_HIGH	(1UL << 2)
 
+/**
+ * struct pixcir_irc_chip_data - chip related data
+ * @num_report_ids:     Max number of finger ids reported simultaneously.
+ *                      if 0 it means chip doesn't support finger id reporting
+ *                      and driver will resort to Type A Multi-Touch reporting.
+ */
+struct pixcir_i2c_chip_data {
+	u8 num_report_ids;
+};
+
 struct pixcir_ts_platform_data {
 	unsigned int x_size;	/* X axis resolution */
 	unsigned int y_size;	/* Y axis resolution */
 	int gpio_attb;		/* GPIO connected to ATTB line */
+	struct pixcir_i2c_chip_data chip;
 };
 
 #endif
-- 
1.8.3.2
