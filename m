From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH 3/6] Input: Implement dev_pm_ops.prepare()
Date: Tue, 31 Mar 2015 18:14:47 +0200
Message-ID: <1427818501-10201-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Have it return 1 in both input_dev_type and input_class (for evdev
handlers) so that input devices that are runtime-suspended won't be
suspended when the system goes to a sleep state. This can make resume
times considerably shorter because these devices don't need to be
resumed when the system is awaken.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/input/input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc357f1..cbbd391 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1741,12 +1741,22 @@ static int input_dev_poweroff(struct device *dev)
 	return 0;
 }
 
+static int input_dev_prepare(struct device *dev)
+{
+	return 1;
+}
+
 static const struct dev_pm_ops input_dev_pm_ops = {
 	.suspend	= input_dev_suspend,
 	.resume		= input_dev_resume,
 	.freeze		= input_dev_freeze,
 	.poweroff	= input_dev_poweroff,
 	.restore	= input_dev_resume,
+	.prepare	= input_dev_prepare,
+};
+
+static const struct dev_pm_ops input_class_pm_ops = {
+	.prepare	= input_dev_prepare,
 };
 #endif /* CONFIG_PM */
 
@@ -1767,6 +1777,9 @@ static char *input_devnode(struct device *dev, umode_t *mode)
 struct class input_class = {
 	.name		= "input",
 	.devnode	= input_devnode,
+#ifdef CONFIG_PM_SLEEP
+	.pm		= &input_class_pm_ops,
+#endif
 };
 EXPORT_SYMBOL_GPL(input_class);
 
-- 
2.3.4
