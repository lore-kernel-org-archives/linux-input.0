From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 05/11] Input: bu21013_ts - remove useless comments
Date: Fri,  9 Aug 2019 17:20:33 -0700
Message-ID: <20190810002039.95876-6-dmitry.torokhov@gmail.com>
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The comments for individual functions in the driver do not provide any
additional information beyond what function names indicate.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/bu21013_ts.c | 61 +-------------------------
 1 file changed, 2 insertions(+), 59 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 0bdadd24296f..a5230f6ea5f0 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -159,14 +159,6 @@ struct bu21013_ts {
 	bool touch_stopped;
 };
 
-/**
- * bu21013_read_block_data(): read the touch co-ordinates
- * @data: bu21013_ts structure pointer
- * @buf: byte pointer
- *
- * Read the touch co-ordinates using i2c read block into buffer
- * and returns integer.
- */
 static int bu21013_read_block_data(struct bu21013_ts *ts, u8 *buf)
 {
 	int ret, i;
@@ -182,13 +174,6 @@ static int bu21013_read_block_data(struct bu21013_ts *ts, u8 *buf)
 	return -EINVAL;
 }
 
-/**
- * bu21013_do_touch_report(): Get the touch co-ordinates
- * @data: bu21013_ts structure pointer
- *
- * Get the touch co-ordinates from touch sensor registers and writes
- * into device structure and returns integer.
- */
 static int bu21013_do_touch_report(struct bu21013_ts *ts)
 {
 	u8	buf[LENGTH_OF_BUFFER];
@@ -243,14 +228,7 @@ static int bu21013_do_touch_report(struct bu21013_ts *ts)
 
 	return 0;
 }
-/**
- * bu21013_gpio_irq() - gpio thread function for touch interrupt
- * @irq: irq value
- * @device_data: void pointer
- *
- * This gpio thread function for touch interrupt
- * and returns irqreturn_t.
- */
+
 static irqreturn_t bu21013_gpio_irq(int irq, void *device_data)
 {
 	struct bu21013_ts *ts = device_data;
@@ -273,13 +251,6 @@ static irqreturn_t bu21013_gpio_irq(int irq, void *device_data)
 	return IRQ_HANDLED;
 }
 
-/**
- * bu21013_init_chip() - power on sequence for the bu21013 controller
- * @data: device structure pointer
- *
- * This function is used to power on
- * the bu21013 controller and returns integer.
- */
 static int bu21013_init_chip(struct bu21013_ts *ts)
 {
 	struct i2c_client *client = ts->client;
@@ -468,14 +439,6 @@ bu21013_parse_dt(struct device *dev)
 }
 #endif
 
-/**
- * bu21013_probe() - initializes the i2c-client touchscreen driver
- * @client: i2c client structure pointer
- * @id: i2c device id pointer
- *
- * This function used to initializes the i2c-client touchscreen
- * driver and returns integer.
- */
 static int bu21013_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -606,13 +569,7 @@ static int bu21013_probe(struct i2c_client *client,
 
 	return error;
 }
-/**
- * bu21013_remove() - removes the i2c-client touchscreen driver
- * @client: i2c client structure pointer
- *
- * This function uses to remove the i2c-client
- * touchscreen driver and returns integer.
- */
+
 static int bu21013_remove(struct i2c_client *client)
 {
 	struct bu21013_ts *ts = i2c_get_clientdata(client);
@@ -634,13 +591,6 @@ static int bu21013_remove(struct i2c_client *client)
 	return 0;
 }
 
-/**
- * bu21013_suspend() - suspend the touch screen controller
- * @dev: pointer to device structure
- *
- * This function is used to suspend the
- * touch panel controller and returns integer
- */
 static int __maybe_unused bu21013_suspend(struct device *dev)
 {
 	struct bu21013_ts *ts = dev_get_drvdata(dev);
@@ -657,13 +607,6 @@ static int __maybe_unused bu21013_suspend(struct device *dev)
 	return 0;
 }
 
-/**
- * bu21013_resume() - resume the touch screen controller
- * @dev: pointer to device structure
- *
- * This function is used to resume the touch panel
- * controller and returns integer.
- */
 static int __maybe_unused bu21013_resume(struct device *dev)
 {
 	struct bu21013_ts *ts = dev_get_drvdata(dev);
-- 
2.23.0.rc1.153.gdeed80330f-goog
