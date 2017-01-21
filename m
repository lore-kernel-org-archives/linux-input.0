From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/13] Input: touchscreen - Use local variables consistently
Date: Sat, 21 Jan 2017 10:46:00 -0800
Message-ID: <1485024365-3368-9-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If a function declares a variable to access a structure element,
use it conssistently.

The conversion was done automatically with coccinelle using
the following semantic patch.

// Catch function parameters.
// Handle those first to trigger reformatting.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
identifier fn;
expression list es;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
- fn(&svar->elem, es)
+ fn(d, es)
...> }

// Now address non-functions and multiple transformations in function
// parameters.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
(
- &svar->elem
+ d
|
- svar->elem.i
+ d->i
)
...> }

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/atmel_mxt_ts.c  | 2 +-
 drivers/input/touchscreen/fsl-imx25-tcq.c | 2 +-
 drivers/input/touchscreen/ili210x.c       | 2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c | 4 ++--
 drivers/input/touchscreen/rohm_bu21023.c  | 3 +--
 drivers/input/touchscreen/s3c2410_ts.c    | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e5d185fe69b9..2302aef2b2d4 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2509,7 +2509,7 @@ static void mxt_debug_init(struct mxt_data *data)
 		dbg->t37_pages = MXT1386_COLUMNS * MXT1386_PAGES_PER_COLUMN;
 	else
 		dbg->t37_pages = DIV_ROUND_UP(data->xsize *
-					      data->info.matrix_ysize *
+					      info->matrix_ysize *
 					      sizeof(u16),
 					      sizeof(dbg->t37_buf->data));
 
diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index d50ee490c9cc..47fe1f184bbc 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -507,7 +507,7 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct input_dev *idev;
 	struct mx25_tcq_priv *priv;
-	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
+	struct mx25_tsadc *tsadc = dev_get_drvdata(dev->parent);
 	struct resource *res;
 	void __iomem *mem;
 	int error;
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index fe4848bd1f4c..91dc5fb34fe1 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -280,7 +280,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		goto err_remove_sysfs;
 	}
 
-	device_init_wakeup(&client->dev, 1);
+	device_init_wakeup(dev, 1);
 
 	dev_dbg(dev,
 		"ILI210x initialized (IRQ: %d), firmware version %d.%d.%d",
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 3bb0637d832e..37ff672c7802 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -461,7 +461,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 		if (error)
 			return error;
 	} else {
-		dev_err(&client->dev, "platform data not defined\n");
+		dev_err(dev, "platform data not defined\n");
 		return -EINVAL;
 	}
 
@@ -483,7 +483,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	input->id.bustype = BUS_I2C;
 	input->open = pixcir_input_open;
 	input->close = pixcir_input_close;
-	input->dev.parent = &client->dev;
+	input->dev.parent = dev;
 
 	if (pdata) {
 		input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
index 611156a2ef80..eeaf6ff03597 100644
--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -1189,8 +1189,7 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client,
 	error = devm_add_action(dev, rohm_ts_remove_sysfs_group, dev);
 	if (error) {
 		rohm_ts_remove_sysfs_group(dev);
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n",
+		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
 	}
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index a4a103e1d11b..41d58e88cc8a 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -250,7 +250,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 
 	ts.dev = dev;
 
-	info = dev_get_platdata(&pdev->dev);
+	info = dev_get_platdata(dev);
 	if (!info) {
 		dev_err(dev, "no platform data, cannot attach\n");
 		return -EINVAL;
-- 
2.7.4
