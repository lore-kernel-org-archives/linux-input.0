From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 1/2] input: egalax_ts: add system wakeup support
Date: Wed,  5 Sep 2018 17:26:46 +0800
Message-ID: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, marco.franchi@nxp.com, fabio.estevam@nxp.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

This patch adds wakeup function support for egalax touch
screen, if "wakeup-source" is added to device tree's egalax
touch screen node, the wakeup function will be enabled, and
egalax touch screen will be able to wakeup system from suspend.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/touchscreen/egalax_ts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 80e69bb..74984ed 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -164,6 +164,7 @@ static int egalax_firmware_version(struct i2c_client *client)
 static int egalax_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
+	struct device_node *np = client->dev.of_node;
 	struct egalax_ts *ts;
 	struct input_dev *input_dev;
 	int error;
@@ -224,6 +225,9 @@ static int egalax_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(&client->dev, true);
+
 	return 0;
 }
 
@@ -241,6 +245,9 @@ static int __maybe_unused egalax_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(client->irq);
+
 	ret = i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
 	return ret > 0 ? 0 : ret;
 }
@@ -249,6 +256,9 @@ static int __maybe_unused egalax_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+	if (device_may_wakeup(dev))
+		return 0;
+
 	return egalax_wake_up_device(client);
 }
 
-- 
2.7.4
