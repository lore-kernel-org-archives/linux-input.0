From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 1/7] Input: Implement dev_pm_ops.prepare in input_class
Date: Fri,  3 Apr 2015 14:57:50 +0200
Message-ID: <1428065887-16017-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1428065887-16017-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1428065887-16017-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Have it return 1 so that input handlers don't block input devices from
remaining runtime suspended when the system goes into a sleep state. For
this to happen, the handler device needs to have runtime PM enabled.

This can make resume times considerably shorter because these devices
won't be resumed when the system is awaken.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/input/input.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc357f1..9666309 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1748,6 +1748,15 @@ static const struct dev_pm_ops input_dev_pm_ops = {
 	.poweroff	= input_dev_poweroff,
 	.restore	= input_dev_resume,
 };
+
+static int input_class_prepare(struct device *dev)
+{
+	return 1;
+}
+
+static const struct dev_pm_ops input_class_pm_ops = {
+	.prepare	= input_class_prepare,
+};
 #endif /* CONFIG_PM */
 
 static struct device_type input_dev_type = {
@@ -1767,6 +1776,9 @@ static char *input_devnode(struct device *dev, umode_t *mode)
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

