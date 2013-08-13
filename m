From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH] input: qt1070: add power management ops
Date: Tue, 13 Aug 2013 15:43:46 +0800
Message-ID: <1376379826-28808-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com
Cc: Wenyou.Yang@atmel.com, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add power management ops for qt1070, it maybe a wakeup source

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/input/keyboard/qt1070.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 42b773b..deefe5a 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -243,6 +243,30 @@ static int qt1070_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int qt1070_suspend(struct device *dev)
+{
+	struct qt1070_data *data = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(data->irq);
+
+	return 0;
+}
+
+static int qt1070_resume(struct device *dev)
+{
+	struct qt1070_data *data = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(data->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(qt1070_pm_ops, qt1070_suspend, qt1070_resume);
+
 static const struct i2c_device_id qt1070_id[] = {
 	{ "qt1070", 0 },
 	{ },
@@ -253,6 +277,7 @@ static struct i2c_driver qt1070_driver = {
 	.driver	= {
 		.name	= "qt1070",
 		.owner	= THIS_MODULE,
+		.pm	= &qt1070_pm_ops,
 	},
 	.id_table	= qt1070_id,
 	.probe		= qt1070_probe,
-- 
1.7.9.5
