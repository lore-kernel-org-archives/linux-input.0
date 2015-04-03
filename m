From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 2/7] Input: Add input_dev.stay_runtime_suspended flag
Date: Fri,  3 Apr 2015 14:57:51 +0200
Message-ID: <1428065887-16017-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1428065887-16017-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428065887-16017-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It indicates that if the device is runtime suspended when the system
goes into a sleep state, it will be left in that state instead of
suspended and resumed.

It's useful for devices such as UVC that register an input device for
the buttons that they may have and that should remain runtime suspended
when the system suspends.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/input/input.c | 8 ++++++++
 include/linux/input.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 9666309..2bcc708 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1741,12 +1741,20 @@ static int input_dev_poweroff(struct device *dev)
 	return 0;
 }
 
+static int input_dev_prepare(struct device *dev)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+
+	return input_dev->stay_runtime_suspended;
+}
+
 static const struct dev_pm_ops input_dev_pm_ops = {
 	.suspend	= input_dev_suspend,
 	.resume		= input_dev_resume,
 	.freeze		= input_dev_freeze,
 	.poweroff	= input_dev_poweroff,
 	.restore	= input_dev_resume,
+	.prepare	= input_dev_prepare,
 };
 
 static int input_class_prepare(struct device *dev)
diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..7466961 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -117,6 +117,9 @@ struct input_value {
  * @vals: array of values queued in the current frame
  * @devres_managed: indicates that devices is managed with devres framework
  *	and needs not be explicitly unregistered or freed.
+ * @stay_runtime_suspended: indicates that if the device is runtime suspended
+ *	when the system goes into a sleep state, it will be left in that state
+ *	instead of suspended and resumed
  */
 struct input_dev {
 	const char *name;
@@ -187,6 +190,7 @@ struct input_dev {
 	struct input_value *vals;
 
 	bool devres_managed;
+	bool stay_runtime_suspended;
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
-- 
2.3.4
