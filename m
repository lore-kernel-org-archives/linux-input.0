From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 2/3] input: touchscreen: edt-ft5x06: assert reset during
 suspend
Date: Thu, 17 May 2018 11:05:51 +0200
Message-ID: <20180517090552.5704-3-daniel@zonque.org>
References: <20180517090552.5704-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517090552.5704-1-daniel@zonque.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com
Cc: devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If the device is not configured as wakeup source, it can be put in reset
during suspend to save some power.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/input/touchscreen/edt-ft5x06.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index e18a2f215500..145499022e1c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -883,6 +883,20 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	}
 }
 
+static void edt_ft5x06_reset(struct edt_ft5x06_ts_data *tsdata, bool reset)
+{
+	if (!tsdata->reset_gpio)
+		return;
+
+	if (reset) {
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
+	} else {
+		usleep_range(5000, 6000);
+		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
+		msleep(300);
+	}
+}
+
 static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
@@ -934,11 +948,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		gpiod_set_value_cansleep(tsdata->wake_gpio, 1);
 	}
 
-	if (tsdata->reset_gpio) {
-		usleep_range(5000, 6000);
-		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
-		msleep(300);
-	}
+	edt_ft5x06_reset(tsdata, false);
 
 	input = devm_input_allocate_device(&client->dev);
 	if (!input) {
@@ -1034,9 +1044,12 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
 static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(client->irq);
+	else
+		edt_ft5x06_reset(tsdata, true);
 
 	return 0;
 }
@@ -1044,9 +1057,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
+	else
+		edt_ft5x06_reset(tsdata, false);
 
 	return 0;
 }
-- 
2.14.3
