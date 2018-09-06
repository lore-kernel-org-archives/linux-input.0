From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2] input: egalax_ts: add system wakeup support
Date: Thu,  6 Sep 2018 11:24:18 +0800
Message-ID: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, fabio.estevam@nxp.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

This patch adds wakeup function support for egalax touch
screen, if "wakeup-source" is added to device tree's egalax
touch screen node, the wakeup function will be enabled, and
egalax touch screen will be able to wakeup system from suspend.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove unnecessary device wakeup check and fix the irq wake balance issue.
 drivers/input/touchscreen/egalax_ts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 80e69bb..83ac8c1 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -241,6 +241,9 @@ static int __maybe_unused egalax_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(client->irq);
+
 	ret = i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
 	return ret > 0 ? 0 : ret;
 }
@@ -249,6 +252,9 @@ static int __maybe_unused egalax_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(client->irq);
+
 	return egalax_wake_up_device(client);
 }
 
-- 
2.7.4
